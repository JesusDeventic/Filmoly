import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:country_picker/country_picker.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/library_taxonomy_options.dart';
import 'package:filmaniak/core/user_preferences.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/library_entry_model.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:filmaniak/widget/filmaniak_country_picker.dart';
import 'package:filmaniak/page/library/library_entry_navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Cómo mostrar la biblioteca: más columnas, tamaño medio o filas tipo lista.
enum LibraryLayoutMode { compact, comfortable, list }

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
  String _filterSearchOption = 'direccion';
  String _filterSearchText = '';
  String? _categorySlug;
  String? _styleSlug;
  String? _genreSlug;
  String? _subgenreSlug;
  int _yearMin = _libraryMinYear;
  int _yearMax = DateTime.now().year;
  final TextEditingController _searchController = TextEditingController();

  /// Borrador del panel de filtros.
  String _draftOrderby = 'date';
  String _draftFilterSearchOption = 'direccion';
  String? _draftCategorySlug;
  String? _draftStyleSlug;
  String? _draftGenreSlug;
  String? _draftSubgenreSlug;
  int _draftYearMin = _libraryMinYear;
  int _draftYearMax = DateTime.now().year;
  final TextEditingController _draftSearchController = TextEditingController();

  String? _countryCode;
  String? _draftCountryCode;
  final TextEditingController _draftCountryFieldController =
      TextEditingController();

  static const int _perPage = 64;
  static const int _libraryMinYear = 1890;

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
    _setLayoutMode(_nextLayoutMode(_layoutMode));
  }

  LibraryLayoutMode _nextLayoutMode(LibraryLayoutMode current) {
    final i = LibraryLayoutMode.values.indexOf(current);
    return LibraryLayoutMode.values[(i + 1) % LibraryLayoutMode.values.length];
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

  String _searchOptionLabel(String value) {
    switch (value) {
      case 'direccion':
        return S.current.librarySearchDirector;
      case 'reparto':
        return S.current.librarySearchCast;
      case 'productoras':
        return S.current.librarySearchStudio;
      case 'other_person':
        return S.current.librarySearchCrew;
      case 'tmdb_id':
        return S.current.librarySearchTmdb;
      case 'imdb_id':
        return S.current.librarySearchImdb;
      default:
        return S.current.librarySearchDirector;
    }
  }

  void _applySearch() {
    _loadInitial();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
    _loadInitial();
  }

  void _syncDraftCountryFieldText() {
    if (_draftCountryCode == null || _draftCountryCode!.isEmpty) {
      _draftCountryFieldController.clear();
      return;
    }
    _draftCountryFieldController.text = Country.parse(
      _draftCountryCode!,
    ).displayNameNoCountryCode;
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
    final q = <String, String>{'orderby': _orderby};
    final currentYear = DateTime.now().year;
    final mainSearchText = _searchController.text.trim();
    final advancedSearchText = _filterSearchText.trim();
    if (advancedSearchText.isNotEmpty) {
      q['opcion_busqueda'] = _filterSearchOption;
      q['texto_busqueda'] = advancedSearchText;
    } else if (mainSearchText.isNotEmpty) {
      q['opcion_busqueda'] = 'title';
      q['texto_busqueda'] = mainSearchText;
    }
    if (_countryCode != null && _countryCode!.isNotEmpty) {
      // Backend filtra por slug ISO (field = slug en taxonomy `paises`).
      q['pais'] = _countryCode!.toLowerCase();
    }
    if (_categorySlug != null && _categorySlug!.isNotEmpty) {
      q['categoria'] = _categorySlug!;
    }
    if (_styleSlug != null && _styleSlug!.isNotEmpty) {
      q['estilo'] = _styleSlug!;
    }
    if (_genreSlug != null && _genreSlug!.isNotEmpty) {
      q['genero'] = _genreSlug!;
    }
    if (_subgenreSlug != null && _subgenreSlug!.isNotEmpty) {
      q['subgenero'] = _subgenreSlug!;
    }
    if (_yearMin > _libraryMinYear) {
      q['year_min'] = '$_yearMin';
    }
    if (_yearMax < currentYear) {
      q['year_max'] = '$_yearMax';
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
        _error =
            result['errorMessage'] as String? ?? S.current.libraryErrorLoad;
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
    _draftOrderby = _orderby;
    _draftFilterSearchOption = _filterSearchOption;
    _draftSearchController.text = _filterSearchText;
    _draftCountryCode = _countryCode;
    _draftCategorySlug = _categorySlug;
    _draftStyleSlug = _styleSlug;
    _draftGenreSlug = _genreSlug;
    _draftSubgenreSlug = _subgenreSlug;
    _draftYearMin = _yearMin;
    _draftYearMax = _yearMax;
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
                    suffixIcon: _draftOrderby != 'date'
                        ? IconButton(
                            tooltip: S.current.filterResetLabel,
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              _draftOrderby = 'date';
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'date',
                      child: Text(S.current.libraryOrderDate),
                    ),
                    DropdownMenuItem(
                      value: 'date_asc',
                      child: Text(S.current.libraryOrderDateAsc),
                    ),
                    DropdownMenuItem(
                      value: 'modified',
                      child: Text(S.current.libraryOrderModified),
                    ),
                    DropdownMenuItem(
                      value: 'modified_asc',
                      child: Text(S.current.libraryOrderModifiedAsc),
                    ),
                    DropdownMenuItem(
                      value: 'title',
                      child: Text(S.current.libraryOrderTitle),
                    ),
                    DropdownMenuItem(
                      value: 'title_desc',
                      child: Text(S.current.libraryOrderTitleDesc),
                    ),
                    DropdownMenuItem(
                      value: 'ficha_fecha_asc',
                      child: Text(S.current.libraryOrderYearAsc),
                    ),
                    DropdownMenuItem(
                      value: 'ficha_fecha_desc',
                      child: Text(S.current.libraryOrderYearDesc),
                    ),
                    DropdownMenuItem(
                      value: 'rf_average_desc',
                      child: Text(S.current.libraryOrderRatingDesc),
                    ),
                    DropdownMenuItem(
                      value: 'rf_average_asc',
                      child: Text(S.current.libraryOrderRatingAsc),
                    ),
                    DropdownMenuItem(
                      value: 'rf_total',
                      child: Text(S.current.libraryOrderRatingCount),
                    ),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    _draftOrderby = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _draftFilterSearchOption,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: S.current.librarySearchFieldLabel,
                          suffixIcon: _draftFilterSearchOption != 'direccion'
                              ? IconButton(
                                  tooltip: S.current.filterResetLabel,
                                  icon: const Icon(
                                    Icons.restart_alt_rounded,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _draftFilterSearchOption = 'direccion';
                                    setModalState(() {});
                                  },
                                )
                              : null,
                        ),
                        selectedItemBuilder: (context) =>
                            [
                                  S.current.librarySearchDirector,
                                  S.current.librarySearchCast,
                                  S.current.librarySearchCrew,
                                  S.current.librarySearchStudio,
                                  S.current.librarySearchTmdb,
                                  S.current.librarySearchImdb,
                                ]
                                .map(
                                  (label) => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      label,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                        items: [
                          DropdownMenuItem(
                            value: 'direccion',
                            child: Text(
                              S.current.librarySearchDirector,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'reparto',
                            child: Text(
                              S.current.librarySearchCast,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'other_person',
                            child: Text(
                              S.current.librarySearchCrew,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'productoras',
                            child: Text(
                              S.current.librarySearchStudio,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'tmdb_id',
                            child: Text(
                              S.current.librarySearchTmdb,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'imdb_id',
                            child: Text(
                              S.current.librarySearchImdb,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          _draftFilterSearchOption = v;
                          setModalState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _draftSearchController,
                        inputFormatters: [LengthLimitingTextInputFormatter(40)],
                        decoration: InputDecoration(
                          labelText: S.current.searchPlaceholder,
                          suffixIcon:
                              _draftSearchController.text.trim().isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded),
                                  onPressed: () {
                                    _draftSearchController.clear();
                                    setModalState(() {});
                                  },
                                )
                              : null,
                        ),
                        onChanged: (_) => setModalState(() {}),
                        onTapOutside: (_) => unFocusGlobal(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _draftYearMin,
                        decoration: InputDecoration(
                          labelText: S.current.libraryFilterYearFromLabel,
                          prefixIcon: const Icon(Icons.event_available_rounded),
                        ),
                        items: [
                          for (
                            var year = _libraryMinYear;
                            year <= DateTime.now().year;
                            year++
                          )
                            DropdownMenuItem<int>(
                              value: year,
                              child: Text('$year'),
                            ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          _draftYearMin = value;
                          if (_draftYearMin > _draftYearMax) {
                            _draftYearMax = _draftYearMin;
                          }
                          setModalState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _draftYearMax,
                        decoration: InputDecoration(
                          labelText: S.current.libraryFilterYearToLabel,
                          prefixIcon: const Icon(Icons.event_rounded),
                        ),
                        items: [
                          for (
                            var year = _libraryMinYear;
                            year <= DateTime.now().year;
                            year++
                          )
                            DropdownMenuItem<int>(
                              value: year,
                              child: Text('$year'),
                            ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          _draftYearMax = value;
                          if (_draftYearMax < _draftYearMin) {
                            _draftYearMin = _draftYearMax;
                          }
                          setModalState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _draftCountryFieldController,
                  readOnly: true,
                  onTap: () {
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
                    hintText: _draftCountryCode == null
                        ? S.current.allLabel
                        : null,
                    suffixIcon: _draftCountryCode != null
                        ? IconButton(
                            tooltip: S.current.removeCountryTooltip,
                            icon: const Icon(Icons.close_rounded, size: 20),
                            onPressed: () {
                              _draftCountryCode = null;
                              _syncDraftCountryFieldText();
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: _draftCategorySlug,
                  isExpanded: true,
                  menuMaxHeight: 380,
                  decoration: InputDecoration(
                    labelText: S.current.libraryFilterCategoryLabel,
                    prefixIcon: const Icon(Icons.movie_creation_outlined),
                    suffixIcon: _draftCategorySlug != null
                        ? IconButton(
                            tooltip: S.current.filterResetLabel,
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              _draftCategorySlug = null;
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(S.current.allLabel),
                    ),
                    ...libraryCategoryOptions.map(
                      (e) => DropdownMenuItem<String?>(
                        value: e.slug,
                        child: Text(
                          e.label(S.current),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    _draftCategorySlug = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: _draftStyleSlug,
                  isExpanded: true,
                  menuMaxHeight: 380,
                  decoration: InputDecoration(
                    labelText: S.current.libraryFilterStyleLabel,
                    prefixIcon: const Icon(Icons.style_outlined),
                    suffixIcon: _draftStyleSlug != null
                        ? IconButton(
                            tooltip: S.current.filterResetLabel,
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              _draftStyleSlug = null;
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(S.current.allLabel),
                    ),
                    ...libraryStyleOptions.map(
                      (e) => DropdownMenuItem<String?>(
                        value: e.slug,
                        child: Text(
                          e.label(S.current),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    _draftStyleSlug = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: _draftGenreSlug,
                  isExpanded: true,
                  menuMaxHeight: 380,
                  decoration: InputDecoration(
                    labelText: S.current.libraryFilterGenreLabel,
                    prefixIcon: const Icon(Icons.category_outlined),
                    suffixIcon: _draftGenreSlug != null
                        ? IconButton(
                            tooltip: S.current.filterResetLabel,
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              _draftGenreSlug = null;
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(S.current.allLabel),
                    ),
                    ...libraryGenreOptions.map(
                      (e) => DropdownMenuItem<String?>(
                        value: e.slug,
                        child: Text(
                          e.label(S.current),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    _draftGenreSlug = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: _draftSubgenreSlug,
                  isExpanded: true,
                  menuMaxHeight: 420,
                  decoration: InputDecoration(
                    labelText: S.current.libraryFilterSubgenreLabel,
                    prefixIcon: const Icon(Icons.label_important_outline_rounded),
                    suffixIcon: _draftSubgenreSlug != null
                        ? IconButton(
                            tooltip: S.current.filterResetLabel,
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              _draftSubgenreSlug = null;
                              setModalState(() {});
                            },
                          )
                        : null,
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(S.current.allLabel),
                    ),
                    ...librarySubgenreOptions.map(
                      (e) => DropdownMenuItem<String?>(
                        value: e.slug,
                        child: Text(
                          e.label(S.current),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    _draftSubgenreSlug = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _draftOrderby = 'date';
                          _draftFilterSearchOption = 'direccion';
                          _draftSearchController.clear();
                          _draftCountryCode = null;
                          _draftCategorySlug = null;
                          _draftStyleSlug = null;
                          _draftGenreSlug = null;
                          _draftSubgenreSlug = null;
                          _draftYearMin = _libraryMinYear;
                          _draftYearMax = DateTime.now().year;
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
                          _filterSearchOption = _draftFilterSearchOption;
                          _filterSearchText = _draftSearchController.text
                              .trim();
                          _countryCode = _draftCountryCode;
                          _categorySlug = _draftCategorySlug;
                          _styleSlug = _draftStyleSlug;
                          _genreSlug = _draftGenreSlug;
                          _subgenreSlug = _draftSubgenreSlug;
                          _yearMin = _draftYearMin;
                          _yearMax = _draftYearMax;
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
          allLoadedEntries: List<LibraryEntry>.from(_entries),
          initialLoadedIndex: globalIndex,
        ),
      ),
    );
  }

 
  int _compactCrossAxisCount(double w) {
    if (w < 600) return 4;
    if (w < 900) return 6;
    if (w < 1200) return 8;
    return 10;
  }

  int _comfortableCrossAxisCount(double w) {
    if (w < 600) return 2;
    if (w < 900) return 3;
    if (w < 1200) return 4;
    return 5;
  }

   int _listCrossAxisCount(double w) {
    if (w < 600) return 2;
    if (w < 900) return 3;
    if (w < 1200) return 4;
    return 5;
  }

  /// Compacta: 4 columnas en móvil (<600dp); más columnas en pantallas grandes.
  /// Cómoda: una columna más que la base + ratio algo mayor (fichas un poco más pequeñas).
  /// Modo lista usa [CustomScrollView] + [SliverGrid] con maxCrossAxisExtent, no este conteo.
  int _crossAxisCountForLayout(double w) {
    switch (_layoutMode) {
      case LibraryLayoutMode.compact:
        return _compactCrossAxisCount(w);
      case LibraryLayoutMode.comfortable:
        return _comfortableCrossAxisCount(w);
      case LibraryLayoutMode.list:
        return _listCrossAxisCount(w);
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

    if (_loading) {
      return const CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
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
              _error!.trim().isNotEmpty ? _error! : S.current.errorAuthGeneric,
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final e = _entries[index];
                return _LibraryListRow(
                  entry: e,
                  onTap: () => _openEntryAt(index),
                );
              }, childCount: _entries.length),
            ),
          ),
          if (_loadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            ),
        ],
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCountForLayout(w),
              childAspectRatio: _childAspectRatioForGrid(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final e = _entries[index];
              return _LibraryTile(entry: e, onTap: () => _openEntryAt(index));
            }, childCount: _entries.length),
          ),
        ),
        if (_loadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              inputFormatters: [LengthLimitingTextInputFormatter(40)],
              decoration: InputDecoration(
                hintText: S.current.librarySearchPlaceholder,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: _clearSearch,
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _applySearch(),
              onTapOutside: (_) => unFocusGlobal(),
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: _applySearch,
              icon: const Icon(Icons.check_rounded),
              tooltip: S.current.membersSearchApplyTooltip,
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
              ),
            ),
          ],
          IconButton(
            tooltip: S.current.filtersTitle,
            icon: const FaIcon(FontAwesomeIcons.filter),
            onPressed: _openFilters,
          ),
          IconButton(
            tooltip: _layoutModeLabel(_nextLayoutMode(_layoutMode)),
            onPressed: () {
              _cycleLayoutMode();
            },
            icon: Icon(_layoutMenuIcon(_nextLayoutMode(_layoutMode))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = MediaQuery.sizeOf(context).width;
    final hasAdvancedSearch = _filterSearchText.trim().isNotEmpty;
    final hasCountryFilter =
        _countryCode != null && _countryCode!.trim().isNotEmpty;
    final hasCategoryFilter =
        _categorySlug != null && _categorySlug!.trim().isNotEmpty;
    final hasStyleFilter = _styleSlug != null && _styleSlug!.trim().isNotEmpty;
    final hasGenreFilter = _genreSlug != null && _genreSlug!.trim().isNotEmpty;
    final hasSubgenreFilter =
        _subgenreSlug != null && _subgenreSlug!.trim().isNotEmpty;
    final currentYear = DateTime.now().year;
    final hasYearFilter =
        _yearMin > _libraryMinYear || _yearMax < currentYear;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(theme),
            if (hasAdvancedSearch ||
                hasCountryFilter ||
                hasCategoryFilter ||
                hasStyleFilter ||
                hasGenreFilter ||
                hasSubgenreFilter ||
                hasYearFilter)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  children: [
                    if (hasAdvancedSearch)
                      Chip(
                        avatar: const Icon(Icons.tune_rounded, size: 18),
                        label: Text(
                          '${_searchOptionLabel(_filterSearchOption)}: ${_filterSearchText.trim()}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        onDeleted: () {
                          setState(() => _filterSearchText = '');
                          _loadInitial();
                        },
                      ),
                    if (hasCountryFilter)
                      Chip(
                        label: Builder(
                          builder: (context) {
                            final country = Country.tryParse(_countryCode!);
                            if (country == null) return Text(_countryCode!);
                            final localizedName =
                                country.getTranslatedName(context) ??
                                country.displayNameNoCountryCode;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(country.flagEmoji),
                                const SizedBox(width: 6),
                                Text(
                                  localizedName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            );
                          },
                        ),
                        onDeleted: () {
                          setState(() => _countryCode = null);
                          _loadInitial();
                        },
                      ),
                    if (hasCategoryFilter)
                      Chip(
                        label: Text(
                          '${S.current.libraryFilterCategoryLabel}: ${labelForTaxonomySlug(S.current, libraryCategoryOptions, _categorySlug)}',
                        ),
                        onDeleted: () {
                          setState(() => _categorySlug = null);
                          _loadInitial();
                        },
                      ),
                    if (hasStyleFilter)
                      Chip(
                        label: Text(
                          '${S.current.libraryFilterStyleLabel}: ${labelForTaxonomySlug(S.current, libraryStyleOptions, _styleSlug)}',
                        ),
                        onDeleted: () {
                          setState(() => _styleSlug = null);
                          _loadInitial();
                        },
                      ),
                    if (hasGenreFilter)
                      Chip(
                        label: Text(
                          '${S.current.libraryFilterGenreLabel}: ${labelForTaxonomySlug(S.current, libraryGenreOptions, _genreSlug)}',
                        ),
                        onDeleted: () {
                          setState(() => _genreSlug = null);
                          _loadInitial();
                        },
                      ),
                    if (hasSubgenreFilter)
                      Chip(
                        label: Text(
                          '${S.current.libraryFilterSubgenreLabel}: ${labelForTaxonomySlug(S.current, librarySubgenreOptions, _subgenreSlug)}',
                        ),
                        onDeleted: () {
                          setState(() => _subgenreSlug = null);
                          _loadInitial();
                        },
                      ),
                    if (hasYearFilter)
                      Chip(
                        label: Text(
                          _yearMin == _yearMax
                              ? '${S.current.libraryFilterYearLabel}: $_yearMin'
                              : '${S.current.libraryFilterYearLabel}: $_yearMin - $_yearMax',
                        ),
                        onDeleted: () {
                          setState(() {
                            _yearMin = _libraryMinYear;
                            _yearMax = DateTime.now().year;
                          });
                          _loadInitial();
                        },
                      ),
                  ],
                ),
              ),
            if (_entries.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                onRefresh: () async {
                  await _loadInitial();
                },
                child: _buildLibraryBody(w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryListRow extends StatelessWidget {
  const _LibraryListRow({required this.entry, required this.onTap});

  final LibraryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final countriesLine = _formatCountriesForUi(context, entry.pais);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxH = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 140.0;
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
                        memCacheWidth: (posterW * dpr).round().clamp(1, 4096),
                        memCacheHeight: (posterH * dpr).round().clamp(1, 4096),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (countriesLine.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                countriesLine,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (entry.director.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                entry.director,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
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

String _formatCountriesForUi(BuildContext context, String rawPais) {
  final raw = rawPais.trim();
  if (raw.isEmpty) return '';

  final parts = raw
      .split(RegExp(r'[,;|]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '';

  final translated = <String>[];
  for (final part in parts) {
    final code = part.toUpperCase();
    final country = Country.tryParse(code);
    if (country != null) {
      final localizedName =
          country.getTranslatedName(context) ??
          country.displayNameNoCountryCode;
      translated.add('${country.flagEmoji} $localizedName');
    } else {
      translated.add(part);
    }
  }
  return translated.join(' · ');
}

String _firstCountryFlagEmoji(String rawPais) {
  final raw = rawPais.trim();
  if (raw.isEmpty) return '';
  final firstPart = raw
      .split(RegExp(r'[,;|]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .cast<String?>()
      .firstWhere((e) => e != null, orElse: () => null);
  if (firstPart == null) return '';
  final country = Country.tryParse(firstPart.toUpperCase());
  return country?.flagEmoji ?? '';
}

class _LibraryTile extends StatelessWidget {
  const _LibraryTile({required this.entry, required this.onTap});

  final LibraryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstFlag = _firstCountryFlagEmoji(entry.pais);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Column(
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
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.05,
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
                    ],
                  ),
                ),
              ],
            ),
            if (firstFlag.isNotEmpty)
              Positioned(
                right: 2,
                bottom: 5,
                child: IgnorePointer(
                  child: Text(
                    firstFlag,
                    style: const TextStyle(fontSize: 12, height: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
