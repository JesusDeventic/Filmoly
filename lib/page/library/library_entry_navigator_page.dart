import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:country_picker/country_picker.dart';
import 'package:filmaniak/model/library_entry_model.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LibraryEntryNavigatorPage extends StatefulWidget {
  const LibraryEntryNavigatorPage({
    super.key,
    this.initialEntry,
    this.initialEntryId,
    this.initialPage = 1,
    this.initialIndexInPage = 0,
    this.initialPageEntries = const [],
    this.perPage = 64,
    this.query = const {},
    this.allLoadedEntries,
    this.initialLoadedIndex,
  }) : assert(
         initialEntry != null || initialEntryId != null,
         'LibraryEntryNavigatorPage requiere initialEntry o initialEntryId.',
       );

  final LibraryEntry? initialEntry;
  final int? initialEntryId;
  final int initialPage;
  final int initialIndexInPage;
  final List<LibraryEntry> initialPageEntries;
  final int perPage;
  final Map<String, String> query;
  final List<LibraryEntry>? allLoadedEntries;
  final int? initialLoadedIndex;

  @override
  State<LibraryEntryNavigatorPage> createState() =>
      _LibraryEntryNavigatorPageState();
}

class _PrevIntent extends Intent {
  const _PrevIntent();
}

class _NextIntent extends Intent {
  const _NextIntent();
}

class _LibraryEntryNavigatorPageState extends State<LibraryEntryNavigatorPage> {
  bool _loading = true;
  String? _error;

  late int _page;
  late int _indexInPage;
  late List<LibraryEntry> _pageEntries;

  /// -1 = desconocido (aún no hemos consultado total_pages).
  int _totalPages = -1;
  bool get _localLoadedMode =>
      widget.allLoadedEntries != null && widget.initialLoadedIndex != null;

  final FocusNode _focusNode = FocusNode(debugLabel: 'LibraryEntryNavigator');
  final Map<int, Map<String, dynamic>> _entryDetailCache = {};
  final Map<int, Map<String, dynamic>> _entryAporteCache = {};
  final Set<int> _loadingDetailIds = {};
  final Set<int> _loadingAporteIds = {};
  final Set<int> _aporteForbiddenIds = {};
  final Map<int, String> _detailErrors = {};
  final Map<int, String> _aporteErrors = {};

  LibraryEntry? get _currentEntry {
    if (_pageEntries.isEmpty) return null;
    if (_indexInPage < 0) return null;
    if (_indexInPage >= _pageEntries.length) return null;
    return _pageEntries[_indexInPage];
  }

  int? get _currentEntryId => _currentEntry?.id;

  Map<String, dynamic>? get _currentDetail {
    final id = _currentEntryId;
    if (id == null) return null;
    return _entryDetailCache[id];
  }

  Map<String, dynamic>? get _currentAporte {
    final id = _currentEntryId;
    if (id == null) return null;
    return _entryAporteCache[id];
  }

  bool get _isCurrentDetailLoading {
    final id = _currentEntryId;
    return id != null && _loadingDetailIds.contains(id);
  }

  bool get _isCurrentAporteLoading {
    final id = _currentEntryId;
    return id != null && _loadingAporteIds.contains(id);
  }

  String? get _currentDetailError {
    final id = _currentEntryId;
    if (id == null) return null;
    return _detailErrors[id];
  }

  String? get _currentAporteError {
    final id = _currentEntryId;
    if (id == null) return null;
    return _aporteErrors[id];
  }

  String get _fallbackInitialTitle {
    if (widget.initialEntry != null) {
      final title = widget.initialEntry!.title.trim();
      if (title.isNotEmpty) return title;
    }
    if (widget.initialEntryId != null && widget.initialEntryId! > 0) {
      return '#${widget.initialEntryId}';
    }
    return '';
  }

  int? get _currentEffectiveEntryId {
    final currentId = _currentEntryId;
    if (currentId != null && currentId > 0) return currentId;
    final fallbackId = widget.initialEntry?.id ?? widget.initialEntryId;
    if (fallbackId != null && fallbackId > 0) return fallbackId;
    return null;
  }

  bool get _canPrev => _page > 1 || _indexInPage > 0;

  bool get _canNext {
    if (_pageEntries.isEmpty) return false;
    if (_localLoadedMode) return _indexInPage + 1 < _pageEntries.length;
    final hasNextInPage = _indexInPage + 1 < _pageEntries.length;
    if (hasNextInPage) return true;
    // Si la página está completa (perPage), es razonable intentar siguiente.
    if (_pageEntries.length == widget.perPage) {
      return _totalPages == -1 || _page < _totalPages;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (_localLoadedMode) {
      _page = 1;
      _pageEntries = widget.allLoadedEntries!;
      _indexInPage = _pageEntries.isEmpty
          ? 0
          : widget.initialLoadedIndex!.clamp(0, _pageEntries.length - 1);
      _totalPages = -1;
      _loading = false;
      _ensureCurrentEntryData();
      return;
    }

    if (widget.initialPageEntries.isNotEmpty) {
      _page = widget.initialPage;
      _indexInPage = widget.initialIndexInPage;
      _pageEntries = widget.initialPageEntries;
      _loading = false;
      _refreshPage();
      _ensureCurrentEntryData();
      return;
    }

    if (widget.initialEntry != null) {
      _page = 1;
      _indexInPage = 0;
      _pageEntries = [widget.initialEntry!];
      _totalPages = -1;
      _loading = false;
      _ensureCurrentEntryData();
      return;
    }

    final bootstrapId = widget.initialEntryId ?? 0;
    _page = 1;
    _indexInPage = 0;
    _pageEntries = [
      LibraryEntry(
        id: bootstrapId,
        title: '',
        thumbnailUrl: '',
        year: '',
        director: '',
        pais: '',
      ),
    ];
    _totalPages = -1;
    _loading = false;
    _ensureCurrentEntryData();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _refreshPage() async {
    if (_localLoadedMode) return;
    if (widget.initialPageEntries.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await FilmaniakApi.getLibrary(
      page: _page,
      perPage: widget.perPage,
      query: widget.query,
    );
    if (!mounted) return;
    if (result['error'] == true) {
      setState(() {
        _loading = false;
        _error = result['errorMessage'] as String?;
      });
      return;
    }

    final posts = result['posts'] as List<LibraryEntry>? ?? <LibraryEntry>[];
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    final totalPages = (pagination['total_pages'] as num?)?.toInt();

    setState(() {
      _pageEntries = posts;
      _totalPages = totalPages ?? _totalPages;
      if (_pageEntries.isEmpty) {
        _indexInPage = 0;
      } else {
        _indexInPage = _indexInPage.clamp(0, _pageEntries.length - 1);
      }
      _loading = false;
    });
    _ensureCurrentEntryData();
  }

  Future<void> _loadPage(int newPage, {required int targetIndex}) async {
    if (_localLoadedMode) return;
    if (widget.initialPageEntries.isEmpty) return;
    if (newPage < 1) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final result = await FilmaniakApi.getLibrary(
      page: newPage,
      perPage: widget.perPage,
      query: widget.query,
    );
    if (!mounted) return;
    if (result['error'] == true) {
      setState(() {
        _loading = false;
        _error = result['errorMessage'] as String?;
      });
      return;
    }

    final posts = result['posts'] as List<LibraryEntry>? ?? <LibraryEntry>[];
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    final totalPages = (pagination['total_pages'] as num?)?.toInt();

    int nextIndex = targetIndex;
    if (targetIndex == -1) {
      nextIndex = posts.isEmpty ? 0 : posts.length - 1; // last item
    } else if (targetIndex == 0) {
      nextIndex = 0;
    }

    setState(() {
      _page = newPage;
      _pageEntries = posts;
      _totalPages = totalPages ?? _totalPages;
      if (_pageEntries.isEmpty) {
        _indexInPage = 0;
      } else {
        _indexInPage = nextIndex.clamp(0, _pageEntries.length - 1);
      }
      _loading = false;
    });
    _ensureCurrentEntryData();
  }

  Future<void> _goPrev() async {
    if (!_canPrev) return;
    if (_localLoadedMode) {
      setState(() => _indexInPage--);
      _ensureCurrentEntryData();
      return;
    }
    if (_indexInPage > 0) {
      setState(() => _indexInPage--);
      _ensureCurrentEntryData();
      return;
    }
    await _loadPage(_page - 1, targetIndex: -1);
  }

  Future<void> _goNext() async {
    if (!_canNext) return;
    if (_localLoadedMode) {
      setState(() => _indexInPage++);
      _ensureCurrentEntryData();
      return;
    }

    final hasNextInPage = _indexInPage + 1 < _pageEntries.length;
    if (hasNextInPage) {
      setState(() => _indexInPage++);
      _ensureCurrentEntryData();
      return;
    }
    await _loadPage(_page + 1, targetIndex: 0);
  }

  Future<void> _ensureCurrentEntryData() async {
    final entryId = _currentEffectiveEntryId;
    if (entryId == null || entryId <= 0) return;
    if (!_entryDetailCache.containsKey(entryId) &&
        !_loadingDetailIds.contains(entryId)) {
      _loadEntryDetail(entryId);
    }
    if (!_entryAporteCache.containsKey(entryId) &&
        !_aporteForbiddenIds.contains(entryId) &&
        !_loadingAporteIds.contains(entryId)) {
      _loadEntryAporte(entryId);
    }
  }

  Future<void> _loadEntryDetail(int entryId) async {
    setState(() {
      _loadingDetailIds.add(entryId);
      _detailErrors.remove(entryId);
    });
    final result = await FilmaniakApi.getLibraryEntryDetail(entryId);
    if (!mounted) return;
    setState(() {
      _loadingDetailIds.remove(entryId);
      if (result['error'] == true) {
        _detailErrors[entryId] =
            (result['errorMessage'] as String?)?.trim().isNotEmpty == true
            ? (result['errorMessage'] as String)
            : 'No se pudo cargar la ficha.';
      } else {
        _entryDetailCache[entryId] =
            result['entry'] as Map<String, dynamic>? ?? <String, dynamic>{};
      }
    });
  }

  Future<void> _loadEntryAporte(int entryId) async {
    setState(() {
      _loadingAporteIds.add(entryId);
      _aporteErrors.remove(entryId);
      _aporteForbiddenIds.remove(entryId);
    });
    final result = await FilmaniakApi.getLibraryEntryAporte(entryId);
    if (!mounted) return;
    setState(() {
      _loadingAporteIds.remove(entryId);
      if (result['error'] == true) {
        final code = (result['code'] as String?) ?? '';
        if (code == 'library_aporte_forbidden') {
          _aporteForbiddenIds.add(entryId);
          _aporteErrors.remove(entryId);
        } else {
          _aporteErrors[entryId] =
              (result['errorMessage'] as String?)?.trim().isNotEmpty == true
              ? (result['errorMessage'] as String)
              : 'No se pudo cargar el aporte.';
        }
      } else {
        _entryAporteCache[entryId] =
            result['entryAporte'] as Map<String, dynamic>? ?? <String, dynamic>{};
      }
    });
  }

  String _safeText(dynamic value) => (value ?? '').toString().trim();

  String _stripHtml(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _joinTermNames(dynamic terms) {
    if (terms is! List) return '';
    final names = <String>[];
    for (final term in terms) {
      if (term is Map) {
        final name = _safeText(term['name']);
        if (name.isNotEmpty) names.add(name);
      }
    }
    return names.join(', ');
  }

  ({String title, String countryCode}) _parseAltTitleWithCountry(String raw) {
    final text = raw.trim();
    if (text.isEmpty) {
      return (title: '', countryCode: '');
    }
    final match = RegExp(r'^(.*?)\s*\(([A-Za-z]{2}(?:-[A-Za-z]{2})?)\)\s*$')
        .firstMatch(text);
    if (match == null) {
      return (title: text, countryCode: '');
    }
    final title = (match.group(1) ?? '').trim();
    final countryOrLocale = (match.group(2) ?? '').trim().toUpperCase();
    final countryCode = countryOrLocale.split('-').first;
    return (title: title, countryCode: countryCode);
  }

  Widget _buildOtherTitlesSection(
    BuildContext context,
    ThemeData theme, {
    required String originalTitle,
    required List<String> alternatives,
  }) {
    final items = <Widget>[];
    if (originalTitle.trim().isNotEmpty) {
      items.add(Text('$originalTitle (Original)', style: theme.textTheme.bodyMedium));
    }

    final parsedAlternatives = alternatives
        .map(_parseAltTitleWithCountry)
        .where((it) => it.title.isNotEmpty)
        .toList()
      ..sort((a, b) {
        final aCode = a.countryCode.trim().toUpperCase();
        final bCode = b.countryCode.trim().toUpperCase();
        final aEmpty = aCode.isEmpty;
        final bEmpty = bCode.isEmpty;
        if (aEmpty != bEmpty) return aEmpty ? 1 : -1; // Sin país al final.
        final byCode = aCode.compareTo(bCode);
        if (byCode != 0) return byCode;
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });

    for (final parsed in parsedAlternatives) {

      String flagEmoji = '';
      String? tooltipCountryName;
      final country = Country.tryParse(parsed.countryCode);
      if (country != null) {
        flagEmoji = country.flagEmoji;
        tooltipCountryName =
            country.getTranslatedName(context) ?? country.displayNameNoCountryCode;
      }

      items.add(
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: [
            if (flagEmoji.isNotEmpty)
              Tooltip(
                message: tooltipCountryName ?? parsed.countryCode,
                child: Text(flagEmoji),
              ),
            Text(parsed.title, style: theme.textTheme.bodyMedium),
          ],
        ),
      );
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Otros títulos:',
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          ...items.map(
            (w) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(ThemeData theme, String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '$label: ',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = _currentEntry;
    final currentDetail = _currentDetail;
    final appBarOriginalTitle =
        _safeText(currentDetail?['title_original']).isNotEmpty
        ? _safeText(currentDetail?['title_original'])
        : (entry?.title.isNotEmpty == true ? entry!.title : _fallbackInitialTitle);

    Widget content() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            appBarOriginalTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            if (_localLoadedMode)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.colorScheme.primary),
                ),
                child: Text(
                  '${_indexInPage + 1} / ${_pageEntries.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primaryFixed,
                  ),
                ),
              ),
            if (!_localLoadedMode && _totalPages != -1)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.colorScheme.primary),
                ),
                child: Text(
                  'Página $_page / $_totalPages',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primaryFixed,
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: _canPrev && !_loading ? _goPrev : null,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: _canNext && !_loading ? _goNext : null,
            ),
          ],
        ),
        body: SafeArea(
          child: _loading && (entry == null || _pageEntries.isEmpty)
              ? emptyDataWidget(
                  context,
                  Icons.hourglass_top_rounded,
                  'Cargando...',
                  '',
                )
              : _error != null && (entry == null)
                  ? emptyDataWidget(
                      context,
                      Icons.error_outline_rounded,
                      _error!.trim().isNotEmpty ? _error! : 'Error',
                      '',
                    )
                  : entry == null
                      ? emptyDataWidget(
                          context,
                          Icons.movie_outlined,
                          'No hay datos',
                          '',
                        )
                      : Builder(
                          builder: (_) {
                            final detail = _currentDetail;
                            final detailError = _currentDetailError;
                            final ids = detail?['ids'] is Map<String, dynamic>
                                ? detail!['ids'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final technical =
                                detail?['technical'] is Map<String, dynamic>
                                ? detail!['technical'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final taxonomies =
                                detail?['taxonomies'] is Map<String, dynamic>
                                ? detail!['taxonomies'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final titles = detail?['titles'] is Map<String, dynamic>
                                ? detail!['titles'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final displayTitle = _safeText(detail?['title']).isNotEmpty
                                ? _safeText(detail?['title'])
                                : entry.title;
                            final posterUrl = _safeText(detail?['thumbnail_url']).isNotEmpty
                                ? _safeText(detail?['thumbnail_url'])
                                : entry.thumbnailUrl;
                            final rfAverage =
                                (detail?['rf_average'] as num?)?.toDouble() ??
                                entry.rfAverage;

                            final category = _joinTermNames(taxonomies['category']);
                            final style = _joinTermNames(taxonomies['post_tag']);
                            final genres = _joinTermNames(taxonomies['genero']);
                            final subgenres =
                                _joinTermNames(taxonomies['subgenero']);
                            final countries = _joinTermNames(taxonomies['paises']);
                            final directors = _joinTermNames(taxonomies['direccion']);
                            final cast = _joinTermNames(taxonomies['reparto']);
                            final studios =
                                _joinTermNames(taxonomies['productoras']);
                            final titleOriginal = _safeText(detail?['title_original']);
                            final alternativesRaw = titles['alternatives'];
                            final alternatives = alternativesRaw is List
                                ? alternativesRaw
                                      .map((e) => _safeText(e))
                                      .where((e) => e.isNotEmpty)
                                      .toList()
                                : <String>[];

                            final year = _safeText(technical['year']).isNotEmpty
                                ? _safeText(technical['year'])
                                : entry.year;
                            final durationMin = _safeText(
                              technical['duration_minutes'],
                            );
                            final synopsis = _stripHtml(_safeText(detail?['content']));

                            final aportePayload = _currentAporte;
                            final aporteError = _currentAporteError;
                            final aporteData =
                                aportePayload?['aporte'] is Map<String, dynamic>
                                ? aportePayload!['aporte'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final aporteAuthor =
                                aportePayload?['author'] is Map<String, dynamic>
                                ? aportePayload!['author'] as Map<String, dynamic>
                                : <String, dynamic>{};
                            final viewerData =
                                aportePayload?['viewer'] is Map<String, dynamic>
                                ? aportePayload!['viewer'] as Map<String, dynamic>
                                : <String, dynamic>{};

                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (_isCurrentDetailLoading)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: LinearProgressIndicator(minHeight: 2),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      displayTitle,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 420,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: filmaniakPosterImage(
                                            context,
                                            imageUrl: posterUrl,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  if (rfAverage != null)
                                    filmaniakRatingBar10(context, rfAverage),
                                  const SizedBox(height: 8),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _detailRow(
                                            theme,
                                            'ID / TMDB / IMDB',
                                            '${entry.id} / ${_safeText(ids['tmdb_id'])} / ${_safeText(ids['imdb_id'])}',
                                          ),
                                          _buildOtherTitlesSection(
                                            context,
                                            theme,
                                            originalTitle: titleOriginal,
                                            alternatives: alternatives,
                                          ),
                                          _detailRow(
                                            theme,
                                            'Categoría',
                                            [
                                              if (category.isNotEmpty) category,
                                              if (style.isNotEmpty) '($style)',
                                            ].join(' '),
                                          ),
                                          _detailRow(theme, 'Géneros', genres),
                                          _detailRow(
                                            theme,
                                            'Subgéneros',
                                            subgenres,
                                          ),
                                          _detailRow(theme, 'Año', year),
                                          _detailRow(theme, 'País', countries),
                                          _detailRow(
                                            theme,
                                            'Duración',
                                            durationMin.isNotEmpty
                                                ? '$durationMin minutos'
                                                : '',
                                          ),
                                          _detailRow(
                                            theme,
                                            'Productoras',
                                            studios,
                                          ),
                                          const Divider(height: 18),
                                          _detailRow(
                                            theme,
                                            'Dirección',
                                            directors.isNotEmpty
                                                ? directors
                                                : entry.director,
                                          ),
                                          _detailRow(
                                            theme,
                                            'Guión',
                                            _safeText(technical['guion']),
                                          ),
                                          _detailRow(
                                            theme,
                                            'Música',
                                            _safeText(technical['musica']),
                                          ),
                                          _detailRow(
                                            theme,
                                            'Fotografía',
                                            _safeText(technical['fotografia']),
                                          ),
                                          _detailRow(theme, 'Reparto', cast),
                                          _detailRow(
                                            theme,
                                            'Premios',
                                            _safeText(technical['premios']),
                                          ),
                                          _detailRow(
                                            theme,
                                            'Curiosidades',
                                            _safeText(technical['curiosidades']),
                                          ),
                                          _detailRow(
                                            theme,
                                            'Frases célebres',
                                            _safeText(
                                              technical['frases_celebres'],
                                            ),
                                          ),
                                          _detailRow(theme, 'Sinopsis', synopsis),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (detailError != null &&
                                      detailError.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        detailError,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: theme.colorScheme.error,
                                            ),
                                      ),
                                    ),
                                  if (_isCurrentAporteLoading ||
                                      aportePayload != null ||
                                      (aporteError != null &&
                                          aporteError.trim().isNotEmpty)) ...[
                                    const SizedBox(height: 12),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Datos de aporte',
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            if (_isCurrentAporteLoading)
                                              const LinearProgressIndicator(
                                                minHeight: 2,
                                              ),
                                            _detailRow(
                                              theme,
                                              'Aportador',
                                              _safeText(
                                                aporteAuthor['display_name'],
                                              ),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Calidad',
                                              _safeText(aporteData['calidad']),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Resolución',
                                              _safeText(
                                                aporteData['resolucion'],
                                              ),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Audio',
                                              _safeText(aporteData['audio']),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Subtítulos',
                                              _safeText(
                                                aporteData['subtitulos'],
                                              ),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tamaño',
                                              _safeText(
                                                        aporteData['tamano_mb'],
                                                      )
                                                      .isNotEmpty
                                                  ? '${_safeText(aporteData['tamano_mb'])} MB'
                                                  : '',
                                            ),
                                            _detailRow(
                                              theme,
                                              'Rango necesario',
                                              _safeText(
                                                aporteData['rango_necesario'],
                                              ),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tu rango',
                                              _safeText(viewerData['rank_title']),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Modificación',
                                              _safeText(aporteData['modificacion']),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tickets',
                                              'Descarga ${_safeText(aporteData['tickets_descarga'])} / Online ${_safeText(aporteData['tickets_online'])}',
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tus tickets',
                                              _safeText(
                                                viewerData['tickets_balance'],
                                              ),
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tickets necesarios',
                                              '${_safeText(aporteData['tickets_descarga'])} (Descarga) / ${_safeText(aporteData['tickets_online'])} (Online) — Tienes ${_safeText(viewerData['tickets_balance'])}',
                                            ),
                                            _detailRow(
                                              theme,
                                              'Cumple rango',
                                              _safeText(
                                                            viewerData['has_required_rank'],
                                                          ) ==
                                                          'true'
                                                  ? 'Sí'
                                                  : 'No',
                                            ),
                                            _detailRow(
                                              theme,
                                              'Tickets suficientes',
                                              _safeText(
                                                            viewerData['has_required_tickets'],
                                                          ) ==
                                                          'true'
                                                  ? 'Sí'
                                                  : 'No',
                                            ),
                                            _detailRow(
                                              theme,
                                              'Info adicional',
                                              _safeText(aporteData['info']),
                                            ),
                                            if (aporteError != null &&
                                                aporteError.trim().isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                ),
                                                child: Text(
                                                  aporteError,
                                                  style: theme
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: theme
                                                            .colorScheme
                                                            .error,
                                                      ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 18),
                                ],
                              ),
                            );
                          },
                        ),
        ),
      );
    }

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): _PrevIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): _NextIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _PrevIntent: CallbackAction<_PrevIntent>(
              onInvoke: (_) => _goPrev(),
            ),
            _NextIntent: CallbackAction<_NextIntent>(
              onInvoke: (_) => _goNext(),
            ),
          },
          child: content(),
        ),
      ),
    );
  }
}

