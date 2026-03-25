import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/model/library_entry_model.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LibraryEntryNavigatorPage extends StatefulWidget {
  const LibraryEntryNavigatorPage({
    super.key,
    required this.initialEntry,
    required this.initialPage,
    required this.initialIndexInPage,
    required this.initialPageEntries,
    required this.perPage,
    required this.query,
    this.allLoadedEntries,
    this.initialLoadedIndex,
  });

  final LibraryEntry initialEntry;
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

  LibraryEntry? get _currentEntry {
    if (_pageEntries.isEmpty) return null;
    if (_indexInPage < 0) return null;
    if (_indexInPage >= _pageEntries.length) return null;
    return _pageEntries[_indexInPage];
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
    } else {
      _page = widget.initialPage;
      _indexInPage = widget.initialIndexInPage;
      _pageEntries = widget.initialPageEntries;

      // Mostramos rápido la entrada ya existente y actualizamos total/pages/consistencia.
      _loading = false;
      _refreshPage();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _refreshPage() async {
    if (_localLoadedMode) return;
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
  }

  Future<void> _loadPage(int newPage, {required int targetIndex}) async {
    if (_localLoadedMode) return;
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
  }

  Future<void> _goPrev() async {
    if (!_canPrev) return;
    if (_localLoadedMode) {
      setState(() => _indexInPage--);
      return;
    }
    if (_indexInPage > 0) {
      setState(() => _indexInPage--);
      return;
    }
    await _loadPage(_page - 1, targetIndex: -1);
  }

  Future<void> _goNext() async {
    if (!_canNext) return;
    if (_localLoadedMode) {
      setState(() => _indexInPage++);
      return;
    }

    final hasNextInPage = _indexInPage + 1 < _pageEntries.length;
    if (hasNextInPage) {
      setState(() => _indexInPage++);
      return;
    }
    await _loadPage(_page + 1, targetIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = _currentEntry;

    Widget content() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            entry?.title ?? widget.initialEntry.title,
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
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 520,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: filmaniakPosterImage(
                                        context,
                                        imageUrl: entry.thumbnailUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (entry.rfAverage != null)
                                filmaniakRatingBar10(
                                  context,
                                  entry.rfAverage!,
                                ),
                              if (entry.year.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    entry.year,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              if (entry.director.isNotEmpty ||
                                  entry.pais.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    [
                                      if (entry.director.isNotEmpty)
                                        entry.director,
                                      if (entry.pais.isNotEmpty) entry.pais,
                                    ].join(' · '),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 18),
                              if (_localLoadedMode)
                                Center(
                                  child: Text(
                                    'Entrada ${_indexInPage + 1} de ${_pageEntries.length}',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                              else if (_totalPages != -1)
                                Center(
                                  child: Text(
                                    'Página $_page de $_totalPages',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                            ],
                          ),
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

