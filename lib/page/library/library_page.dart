import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:country_picker/country_picker.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/user_preferences.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/library_entry_model.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:filmaniak/widget/filmaniak_country_picker.dart';
import 'package:filmaniak/page/library/library_entry_navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Cómo mostrar la biblioteca: más columnas, tamaño medio o filas tipo lista.
enum LibraryLayoutMode {
  compact,
  comfortable,
  list,
}

/// Contenido de la biblioteca (entradas del sitio). Va embebido en Home.
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final ScrollController _scrollController = ScrollController();

  final List<LibraryEntry> _entries = [];
  int _page = 1;
  int _totalPages = 1;
  int _totalFound = 0;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;
  bool _disposed = false;

  LibraryLayoutMode _layoutMode = LibraryLayoutMode.compact;

  /// Parámetros GET del endpoint (mismos nombres que WordPress).
  String _orderby = 'date';
  String _opcionBusqueda = 'title';
  final TextEditingController _searchController = TextEditingController();

  /// Borrador del panel de filtros.
  String _draftOrderby = 'date';
  String _draftOpcion = 'title';
  final TextEditingController _draftSearchController = TextEditingController();

  String? _countryCode;
  String? _draftCountryCode;
  final TextEditingController _draftCountryFieldController = TextEditingController();

  static const int _perPage = 24;

  /// Vista lista: columnas según ancho (misma idea que [MembersListPage] en modo lista).
  static const double _libraryListMaxCrossAxisExtent = 450;
  static const double _libraryListRowExtent = 120;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadLayoutPreference();
    _loadInitial();
  }

  Future<void> _loadLayoutPreference() async {
    final name = await UserPreferences().getLibraryLayout();
    if (!mounted || name == null || name.isEmpty) return;
    for (final m in LibraryLayoutMode.values) {
      if (m.name == name) {
        setState(() => _layoutMode = m);
        break;
      }
    }
  }

  Future<void> _setLayoutMode(LibraryLayoutMode mode) async {
    setState(() => _layoutMode = mode);
    await UserPreferences().setLibraryLayout(mode.name);
  }

  void _cycleLayoutMode() {
    final i = LibraryLayoutMode.values.indexOf(_layoutMode);
    final next =
        LibraryLayoutMode.values[(i + 1) % LibraryLayoutMode.values.length];
    _setLayoutMode(next);
  }

  String _layoutModeLabel(LibraryLayoutMode m) {
    switch (m) {
      case LibraryLayoutMode.compact:
        return S.current.libraryLayoutCompact;
      case LibraryLayoutMode.comfortable:
        return S.current.libraryLayoutComfortable;
      case LibraryLayoutMode.list:
        return S.current.libraryLayoutList;
    }
  }

  IconData _layoutMenuIcon(LibraryLayoutMode m) {
    switch (m) {
      case LibraryLayoutMode.compact:
        return Icons.grid_on_rounded;
      case LibraryLayoutMode.comfortable:
        return Icons.grid_view_rounded;
      case LibraryLayoutMode.list:
        return Icons.view_list_rounded;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _scrollController.dispose();
    _searchController.dispose();
    _draftSearchController.dispose();
    _draftCountryFieldController.dispose();
    super.dispose();
  }

  void _syncDraftCountryFieldText() {
    if (_draftCountryCode == null || _draftCountryCode!.isEmpty) {
      _draftCountryFieldController.clear();
      return;
    }
    _draftCountryFieldController.text =
        Country.parse(_draftCountryCode!).displayNameNoCountryCode;
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 280) {
      if (!_loadingMore && _page < _totalPages && !_loading) {
        _loadMore();
      }
    }
  }

  Map<String, String> _queryParams() {
    final q = <String, String>{
      'orderby': _orderby,
    };
    final t = _searchController.text.trim();
    if (t.isNotEmpty) {
      q['opcion_busqueda'] = _opcionBusqueda;
      q['texto_busqueda'] = t;
    }
    if (_countryCode != null && _countryCode!.isNotEmpty) {
      // Backend filtra por slug ISO (field = slug en taxonomy `paises`).
      q['pais'] = _countryCode!.toLowerCase();
    }
    return q;
  }

  Future<void> _loadInitial() async {
    if (!_disposed) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    final result = await FilmaniakApi.getLibrary(
      page: 1,
      perPage: _perPage,
      query: _queryParams(),
    );
    if (!mounted || _disposed) return;
    if (result['error'] == true) {
      setState(() {
        _entries.clear();
        _loading = false;
        _error = result['errorMessage'] as String? ?? S.current.libraryErrorLoad;
      });
      return;
    }
    final posts = result['posts'] as List<LibraryEntry>? ?? [];
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    setState(() {
      _entries
        ..clear()
        ..addAll(posts);
      _page = (pagination['page'] as num?)?.toInt() ?? 1;
      _totalPages = (pagination['total_pages'] as num?)?.toInt() ?? 1;
      _totalFound = (pagination['total'] as num?)?.toInt() ?? posts.length;
      _loading = false;
      _error = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _disposed) return;
      _ensureFillScroll();
    });
  }

  Future<void> _loadMore() async {
    if (_loadingMore || _page >= _totalPages) return;
    setState(() => _loadingMore = true);
    final next = _page + 1;
    final result = await FilmaniakApi.getLibrary(
      page: next,
      perPage: _perPage,
      query: _queryParams(),
    );
    if (!mounted || _disposed) return;
    if (result['error'] == true) {
      setState(() => _loadingMore = false);
      return;
    }
    final posts = result['posts'] as List<LibraryEntry>? ?? [];
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    setState(() {
      _page = (pagination['page'] as num?)?.toInt() ?? next;
      _totalPages = (pagination['total_pages'] as num?)?.toInt() ?? _totalPages;
      _totalFound = (pagination['total'] as num?)?.toInt() ?? _totalFound;
      _entries.addAll(posts);
      _loadingMore = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _disposed) return;
      _ensureFillScroll();
    });
  }

  void _ensureFillScroll() {
    if (_disposed || _loadingMore || _page >= _totalPages) return;
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.maxScrollExtent <= 48) {
      _loadMore();
    }
  }

  Future<void> _openFilters() async {
    unFocusGlobal();
    _draftOrderby = _orderby;
    _draftOpcion = _opcionBusqueda;
    _draftSearchController.text = _searchController.text;
    _draftCountryCode = _countryCode;
    _syncDraftCountryFieldText();
    await showDraggableAppSheet(
      context,
      title: S.current.filtersTitle,
      titleFontSize: 18,
      intrinsicHeight: true,
      bodyBuilder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _draftOrderby,
                  decoration: InputDecoration(
                    labelText: S.current.sortByLabel,
                    prefixIcon: const Icon(Icons.sort_rounded),
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 'date', child: Text(S.current.libraryOrderDate)),
                    DropdownMenuItem(
                        value: 'modified',
                        child: Text(S.current.libraryOrderModified)),
                    DropdownMenuItem(
                        value: 'title', child: Text(S.current.libraryOrderTitle)),
                    DropdownMenuItem(
                        value: 'ficha_fecha_asc',
                        child: Text(S.current.libraryOrderYearAsc)),
                    DropdownMenuItem(
                        value: 'ficha_fecha_desc',
                        child: Text(S.current.libraryOrderYearDesc)),
                    DropdownMenuItem(
                        value: 'rf_average_desc',
                        child: Text(S.current.libraryOrderRatingDesc)),
                    DropdownMenuItem(
                        value: 'rf_average_asc',
                        child: Text(S.current.libraryOrderRatingAsc)),
                    DropdownMenuItem(
                        value: 'rf_total',
                        child: Text(S.current.libraryOrderRatingCount)),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    _draftOrderby = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _draftOpcion,
                  decoration: InputDecoration(
                    labelText: S.current.librarySearchFieldLabel,
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 'title', child: Text(S.current.librarySearchTitle)),
                    DropdownMenuItem(
                        value: 'direccion',
                        child: Text(S.current.librarySearchDirector)),
                    DropdownMenuItem(
                        value: 'reparto', child: Text(S.current.librarySearchCast)),
                    DropdownMenuItem(
                        value: 'productoras',
                        child: Text(S.current.librarySearchStudio)),
                    DropdownMenuItem(
                        value: 'other_person',
                        child: Text(S.current.librarySearchCrew)),
                    DropdownMenuItem(
                        value: 'tmdb_id', child: Text(S.current.librarySearchTmdb)),
                    DropdownMenuItem(
                        value: 'imdb_id', child: Text(S.current.librarySearchImdb)),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    _draftOpcion = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _draftSearchController,
                  decoration: InputDecoration(
                    labelText: S.current.librarySearchPlaceholder,
                    prefixIcon: const Icon(Icons.edit_rounded),
                  ),
                  onChanged: (_) => setModalState(() {}),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _draftCountryFieldController,
                  readOnly: true,
                  onTap: () {
                    unFocusGlobal();
                    showFilmaniakCountryPicker(
                      context: context,
                      favorite: _draftCountryCode != null
                          ? [_draftCountryCode!]
                          : [],
                      showPhoneCode: false,
                      onSelect: (country) {
                        _draftCountryCode = country.countryCode;
                        _syncDraftCountryFieldText();
                        setModalState(() {});
                      },
                    );
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.public_rounded),
                    labelText: S.current.textfieldUserCountryLabel,
                    hintText:
                        _draftCountryCode == null ? S.current.allLabel : null,
                    suffixIcon: _draftCountryCode != null
                        ? IconButton(
                            tooltip: S.current.removeCountryTooltip,
                            icon: const Icon(Icons.close_rounded, size: 20),
                            onPressed: () {
                              unFocusGlobal();
                              _draftCountryCode = null;
                              _syncDraftCountryFieldText();
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _draftOrderby = 'date';
                          _draftOpcion = 'title';
                          _draftSearchController.clear();
                          _draftCountryCode = null;
                          _syncDraftCountryFieldText();
                          setModalState(() {});
                        },
                        child: Text(S.current.filterResetLabel),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _orderby = _draftOrderby;
                          _opcionBusqueda = _draftOpcion;
                          _searchController.text = _draftSearchController.text;
                          _countryCode = _draftCountryCode;
                          Navigator.of(context).pop();
                          _loadInitial();
                        },
                        child: Text(S.current.filterApplyLabel),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _openEntryAt(int globalIndex) async {
    if (globalIndex < 0 || globalIndex >= _entries.length) return;

    // Mapeo globalIndex -> page/index dentro de la page (porque siempre cargamos desde page=1).
    final initialPage = (globalIndex ~/ _perPage) + 1;
    final initialIndexInPage = globalIndex % _perPage;

    final start = (initialPage - 1) * _perPage;
    final endCandidate = start + _perPage;
    final end = endCandidate > _entries.length ? _entries.length : endCandidate;
    final initialPageEntries = _entries.sublist(start, end);

    final queryParams = Map<String, String>.from(_queryParams());
    final entry = _entries[globalIndex];

    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LibraryEntryNavigatorPage(
          initialEntry: entry,
          initialPage: initialPage,
          initialIndexInPage: initialIndexInPage,
          initialPageEntries: initialPageEntries,
          perPage: _perPage,
          query: queryParams,
        ),
      ),
    );
  }

  int _baseCrossAxisCount(double w) {
    if (w >= 1200) return 5;
    if (w >= 900) return 4;
    if (w >= 600) return 3;
    return 2;
  }

  /// Compacta: 4 columnas en móvil (<600dp); más columnas en pantallas grandes.
  /// Cómoda: una columna más que la base + ratio algo mayor (fichas un poco más pequeñas).
  /// Modo lista usa [CustomScrollView] + [SliverGrid] con maxCrossAxisExtent, no este conteo.
  int _crossAxisCountForLayout(double w) {
    switch (_layoutMode) {
      case LibraryLayoutMode.compact:
        if (w < 600) return 4;
        if (w < 900) return 5;
        if (w < 1200) return 6;
        return 7;
      case LibraryLayoutMode.comfortable:
        return _baseCrossAxisCount(w);
      case LibraryLayoutMode.list:
        return _baseCrossAxisCount(w);
    }
  }

  /// Ratio mayor = menos alto por celda (fichas más bajas).
  double _childAspectRatioForGrid() {
    switch (_layoutMode) {
      case LibraryLayoutMode.compact:
        return 0.58;
      case LibraryLayoutMode.comfortable:
        return 0.58;
      case LibraryLayoutMode.list:
        return 0.52;
    }
  }

  Widget _buildLibraryBody(double w) {
    final h = MediaQuery.sizeOf(context).height;

    if (_loading && _entries.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: h * 0.35,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    if (_error != null && _entries.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: h * 0.45,
            child: emptyDataWidget(
              context,
              Icons.error_outline_rounded,
              S.current.libraryErrorLoad,
              _error!.trim().isNotEmpty
                  ? _error!
                  : S.current.errorAuthGeneric,
            ),
          ),
        ],
      );
    }

    if (_entries.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: h * 0.45,
            child: emptyDataWidget(
              context,
              Icons.movie_outlined,
              S.current.libraryEmpty,
              S.current.libraryEmptySubtitle,
            ),
          ),
        ],
      );
    }

    if (_layoutMode == LibraryLayoutMode.list) {
      return CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _libraryListMaxCrossAxisExtent,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: _libraryListRowExtent,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final e = _entries[index];
                  return _LibraryListRow(
                    entry: e,
                    onTap: () => _openEntryAt(index),
                  );
                },
                childCount: _entries.length,
              ),
            ),
          ),
          if (_loadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      );
    }

    return GridView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCountForLayout(w),
        childAspectRatio: _childAspectRatioForGrid(),
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
      ),
      itemCount: _entries.length + (_loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _entries.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
        final e = _entries[index];
        return _LibraryTile(
          entry: e,
          onTap: () => _openEntryAt(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  S.current.menuLibrary,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip:
                    '${S.current.libraryViewModeTitle}: ${_layoutModeLabel(_layoutMode)}',
                onPressed: () {
                  unFocusGlobal();
                  _cycleLayoutMode();
                },
                icon: Icon(_layoutMenuIcon(_layoutMode)),
              ),
              IconButton(
                tooltip: S.current.filtersTitle,
                icon: const FaIcon(FontAwesomeIcons.filter),
                onPressed: _openFilters,
              ),
            ],
          ),
        ),
        if (_entries.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              S.current.libraryResultsTotal(_totalFound),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        const SizedBox(height: 8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadInitial,
            child: _buildLibraryBody(w),
          ),
        ),
      ],
    );
  }

}

class _LibraryListRow extends StatelessWidget {
  const _LibraryListRow({
    required this.entry,
    required this.onTap,
  });

  final LibraryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxH = constraints.hasBoundedHeight ? constraints.maxHeight : 140.0;
        // Queremos que el póster use el alto casi completo del item (sin padding).
        final verticalPadding = 0.0;
        final posterH = (maxH - verticalPadding).clamp(56.0, 140.0);
        // Un poco más ancho para parecerse a la tarjeta de grid.
        final posterW = (posterH * 0.78).clamp(44.0, 86.0);
        final dpr = MediaQuery.devicePixelRatioOf(context);

        return SizedBox.expand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      width: posterW,
                      height: posterH,
                      child: filmaniakPosterImage(
                        context,
                        imageUrl: entry.thumbnailUrl,
                        fit: BoxFit.contain,
                        memCacheWidth: (posterW * dpr)
                            .round()
                            .clamp(1, 4096),
                        memCacheHeight: (posterH * dpr)
                            .round()
                            .clamp(1, 4096),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (entry.rfAverage != null) ...[
                          filmaniakRatingBar10(
                            context,
                            entry.rfAverage!,
                            inline: true,
                          ),
                          const SizedBox(height: 4),
                        ],
                        Text(
                          entry.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            height: 1.2,
                          ),
                        ),
                        if (entry.year.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              entry.year,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        if (entry.director.isNotEmpty || entry.pais.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              [
                                if (entry.director.isNotEmpty) entry.director,
                                if (entry.pais.isNotEmpty) entry.pais,
                              ].join(' · '),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LibraryTile extends StatelessWidget {
  const _LibraryTile({
    required this.entry,
    required this.onTap,
  });

  final LibraryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (entry.rfAverage != null)
              filmaniakRatingBar10(context, entry.rfAverage!),
            Expanded(
              child: filmaniakPosterImage(
                context,
                imageUrl: entry.thumbnailUrl,
                fit: BoxFit.contain,
                memCacheWidth: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    entry.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.15,
                    ),
                  ),
                  if (entry.year.isNotEmpty)
                    Text(
                      entry.year,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (entry.director.isNotEmpty || entry.pais.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        [
                          if (entry.director.isNotEmpty) entry.director,
                          if (entry.pais.isNotEmpty) entry.pais,
                        ].join(' · '),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
