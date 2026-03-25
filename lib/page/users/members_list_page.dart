import 'package:country_picker/country_picker.dart';
import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/page/users/public_user_profile_page.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:filmaniak/widget/filmaniak_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MembersListPage extends StatefulWidget {
  const MembersListPage({super.key});

  @override
  State<MembersListPage> createState() => _MembersListPageState();
}

class _MembersListPageState extends State<MembersListPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _filterCountryFieldController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// Más columnas en pantallas anchas; menos en móviles (como Fitcron, vía maxCrossAxisExtent).
  double _gridMaxCrossAxisExtent(double viewportWidth) {
    final w = viewportWidth;
    if (w >= 1600) return 72;
    if (w >= 1200) return 76;
    if (w >= 900) return 80;
    if (w >= 600) return 86;
    if (w >= 420) return 92;
    return 100;
  }

  String _countryFlagEmoji(FilmaniakUser user) {
    if (user.country.isEmpty) return '';
    return Country.tryParse(user.country)?.flagEmoji ?? '';
  }

  /// Bandera sobre la imagen, esquina inferior izquierda (lista y grid).
  Widget _countryFlagOnAvatarCorner(String flag) {
    if (flag.isEmpty) return const SizedBox.shrink();
    return Positioned(
      left: 0,
      top: 0,
      child: Text(
        flag,
        style: const TextStyle(fontSize: 22, height: 1.0),
      ),
    );
  }

  final int _perPage = 24;
  String _searchText = '';
  /// Filtro de país aplicado (API + chip bajo el buscador).
  String? _countryCode;
  String _selectedOrder = 'registered_desc';

  /// Borrador del panel de filtros; solo pasa a aplicado con «Aplicar».
  String? _filterDraftCountry;
  String _filterDraftOrder = 'registered_desc';

  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  bool _hasError = false;
  bool _hasMore = true;
  bool _disposed = false;

  int _currentPage = 1;
  int _totalPages = 1;
  int _totalUsers = 0;
  final List<FilmaniakUser> _members = [];
  String? _errorDetail;

  bool _isGridMode = true;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _disposed = true;
    _scrollController.dispose();
    _searchController.dispose();
    _filterCountryFieldController.dispose();
    super.dispose();
  }

  void _syncFilterCountryFieldTextForSheet() {
    if (_filterDraftCountry == null || _filterDraftCountry!.isEmpty) {
      _filterCountryFieldController.clear();
      return;
    }
    try {
      _filterCountryFieldController.text =
          Country.parse(_filterDraftCountry!).displayNameNoCountryCode;
    } catch (_) {
      _filterCountryFieldController.text = _filterDraftCountry!;
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMore && !_isLoadingMore && !_disposed) {
        _loadMore();
      }
    }
  }

  /// Pantallas grandes: la primera página no llena el viewport, no hay scroll y no se
  /// dispara `_onScroll`. Precargamos hasta que haya recorrido o no queden páginas
  /// (misma idea que Fitcron con `listMembers.length < 50`).
  void _scheduleFillViewportIfNeeded() {
    if (_disposed) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_disposed) return;
      await _fillViewportIfUnderflow(retriesLeft: 8);
    });
  }

  Future<void> _fillViewportIfUnderflow({required int retriesLeft}) async {
    if (_disposed || !_hasMore || _isLoadingMore || _isInitialLoading) return;
    if (!_scrollController.hasClients) {
      if (retriesLeft <= 0) return;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (_disposed) return;
        await _fillViewportIfUnderflow(retriesLeft: retriesLeft - 1);
      });
      return;
    }
    final maxExtent = _scrollController.position.maxScrollExtent;
    if (maxExtent <= 0 && _hasMore) {
      await _loadMore();
      if (!_disposed && _hasMore) {
        _scheduleFillViewportIfNeeded();
      }
    }
  }

  Map<String, String> _getOrderParams() {
    switch (_selectedOrder) {
      case 'name_asc':
        return {'orderBy': 'name', 'order': 'asc'};
      case 'name_desc':
        return {'orderBy': 'name', 'order': 'desc'};
      case 'age_asc':
        return {'orderBy': 'birth_date', 'order': 'desc'};
      case 'age_desc':
        return {'orderBy': 'birth_date', 'order': 'asc'};
      case 'registered_asc':
        return {'orderBy': 'registered_date', 'order': 'asc'};
      case 'registered_desc':
      default:
        return {'orderBy': 'registered_date', 'order': 'desc'};
    }
  }

  Future<Map<String, dynamic>> _fetchPage(int page) {
    final order = _getOrderParams();
    return FilmaniakApi.getMembers(
      page: page,
      perPage: _perPage,
      search: _searchText.isNotEmpty ? _searchText : null,
      country: _countryCode,
      orderBy: order['orderBy'],
      order: order['order'],
    );
  }

  Future<void> _loadInitial() async {
    unFocusGlobal();
    if (!_disposed) {
      setState(() {
        _isInitialLoading = true;
        _hasError = false;
      });
    }

    try {
      final result = await _fetchPage(1);
      final apiError = result['error'] == true;
      final users = (result['users'] as List<FilmaniakUser>? ?? []);
      final pagination =
          result['pagination'] as Map<String, dynamic>? ?? <String, dynamic>{};

      if (!_disposed) {
        setState(() {
          _members
            ..clear()
            ..addAll(users);
          _currentPage = 1;
          _totalPages = (pagination['totalPages'] as num?)?.toInt() ?? 1;
          _totalUsers = (pagination['total'] as num?)?.toInt() ?? users.length;
          _hasMore = _currentPage < _totalPages;
          _hasError = apiError;
          _errorDetail = result['errorMessage'] as String?;
          _isLoadingMore = false;
          _isInitialLoading = false;
        });
        _scheduleFillViewportIfNeeded();
      }
    } catch (_) {
      if (!_disposed) {
        setState(() {
          _members.clear();
          _hasError = true;
          _errorDetail = null;
          _isInitialLoading = false;
          _isLoadingMore = false;
          _hasMore = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore || _currentPage >= _totalPages) return;
    if (!_disposed) setState(() => _isLoadingMore = true);

    try {
      final result = await _fetchPage(_currentPage + 1);
      final users = (result['users'] as List<FilmaniakUser>? ?? []);
      final pagination =
          result['pagination'] as Map<String, dynamic>? ?? <String, dynamic>{};

      if (!_disposed) {
        setState(() {
          _currentPage++;
          _members.addAll(users);
          _totalPages = (pagination['totalPages'] as num?)?.toInt() ?? _totalPages;
          _totalUsers = (pagination['total'] as num?)?.toInt() ?? _totalUsers;
          _hasMore = _currentPage < _totalPages;
          _isLoadingMore = false;
        });
        _scheduleFillViewportIfNeeded();
      }
    } catch (_) {
      if (!_disposed) {
        setState(() {
          _isLoadingMore = false;
          _hasMore = false;
        });
      }
    }
  }

  void _applySearch() {
    unFocusGlobal();
    setState(() {
      _searchText = _searchController.text.trim();
    });
    _loadInitial();
  }

  void _clearSearch() {
    unFocusGlobal();
    setState(() {
      _searchController.clear();
      _searchText = '';
    });
    _loadInitial();
  }

  void _openFilterSheet() {
    unFocusGlobal();
    _filterDraftCountry = _countryCode;
    _filterDraftOrder = _selectedOrder;
    _syncFilterCountryFieldTextForSheet();
    showDraggableAppSheet(
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
                  value: _filterDraftOrder,
                  decoration: InputDecoration(
                    labelText: S.current.sortByLabel,
                    prefixIcon: const Icon(Icons.sort_rounded),
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 'name_asc',
                        child: Text(S.current.membersSortNameAsc)),
                    DropdownMenuItem(
                        value: 'name_desc',
                        child: Text(S.current.membersSortNameDesc)),
                    DropdownMenuItem(
                        value: 'age_asc',
                        child: Text(S.current.membersSortAgeAsc)),
                    DropdownMenuItem(
                        value: 'age_desc',
                        child: Text(S.current.membersSortAgeDesc)),
                    DropdownMenuItem(
                        value: 'registered_asc',
                        child: Text(S.current.membersSortRegisteredAsc)),
                    DropdownMenuItem(
                        value: 'registered_desc',
                        child: Text(S.current.membersSortRegisteredDesc)),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    _filterDraftOrder = v;
                    setModalState(() {});
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.public_rounded),
                    labelText: S.current.textfieldUserCountryLabel,
                    hintText: _filterDraftCountry == null
                        ? S.current.allLabel
                        : null,
                    suffixIcon: _filterDraftCountry != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Country.parse(_filterDraftCountry!).flagEmoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                              IconButton(
                                tooltip: S.current.removeCountryTooltip,
                                icon: const Icon(Icons.close_rounded, size: 20),
                                onPressed: () {
                                  unFocusGlobal();
                                  _filterDraftCountry = null;
                                  _filterCountryFieldController.clear();
                                  setModalState(() {});
                                },
                              ),
                            ],
                          )
                        : null,
                  ),
                  controller: _filterCountryFieldController,
                  readOnly: true,
                  onTap: () {
                    unFocusGlobal();
                    showFilmaniakCountryPicker(
                      context: context,
                      favorite: _filterDraftCountry != null
                          ? [_filterDraftCountry!]
                          : [],
                      showPhoneCode: false,
                      onSelect: (country) {
                        _filterDraftCountry = country.countryCode;
                        _filterCountryFieldController.text =
                            country.displayNameNoCountryCode;
                        setModalState(() {});
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _filterDraftOrder = 'registered_desc';
                          _filterDraftCountry = null;
                          _filterCountryFieldController.clear();
                          setState(() {
                            _selectedOrder = 'registered_desc';
                            _countryCode = null;
                          });
                          Navigator.of(context).pop();
                          _loadInitial();
                        },
                        child: Text(S.current.filterResetLabel),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _countryCode = _filterDraftCountry;
                            _selectedOrder = _filterDraftOrder;
                          });
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

  Widget _buildSearchBar() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.current.membersSearchHint,
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
            onPressed: _openFilterSheet,
            icon: const FaIcon(FontAwesomeIcons.filter),
            tooltip: S.current.filtersTitle,
          ),
        ],
      ),
    );
  }

  void _openMemberProfile(FilmaniakUser user, int globalIndex) {
    /// Evitar que el teclado vuelva a enfocar el buscador al regresar (como Fitcron).
    unFocusGlobal();

    final initialPage = (globalIndex ~/ _perPage) + 1;
    final initialIndexInPage = globalIndex % _perPage;
    final start = (initialPage - 1) * _perPage;
    final endCandidate = start + _perPage;
    final end = endCandidate > _members.length ? _members.length : endCandidate;
    final initialPageUsers = _members.sublist(start, end);

    final order = _getOrderParams();
    final orderBy = order['orderBy'] as String;
    final orderParam = order['order'] as String;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PublicUserProfilePage(
          username: user.username,
          initialUser: user,
          navInitialPage: initialPage,
          navInitialIndexInPage: initialIndexInPage,
          navInitialPageUsers: initialPageUsers,
          navPerPage: _perPage,
          navSearch: _searchText.isNotEmpty ? _searchText : null,
          navCountryCode: _countryCode,
          navOrderBy: orderBy,
          navOrder: orderParam,
          navTotalPages: _totalPages,
        ),
      ),
    );
  }

  Widget _buildMemberGridTile(FilmaniakUser user, int globalIndex) {
    final theme = Theme.of(context);
    final display =
        user.displayName.isNotEmpty ? user.displayName : user.username;
    final flag = _countryFlagEmoji(user);
    final nameStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 11,
      height: 1.0,
    );
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openMemberProfile(user, globalIndex),
        child: Padding(
          padding: _listCardInnerPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final s = constraints.maxWidth;
                    return Stack(
                      clipBehavior: Clip.hardEdge,
                      fit: StackFit.expand,
                      children: [
                        avatarWidget(
                          user.avatarUrl,
                          context,
                          user.username,
                          disableOnTap: true,
                          size: s,
                        ),
                        _countryFlagOnAvatarCorner(flag),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
              Text(
                display,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: nameStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const double _listRowMainAxisExtent = 96;

  /// Mismo aire interior que en `_buildMemberGridTile`.
  static const EdgeInsets _listCardInnerPadding =
      EdgeInsets.fromLTRB(4, 4, 4, 6);

  Widget _buildMemberCard(FilmaniakUser user, int globalIndex) {
    final theme = Theme.of(context);
    final countryFlag = _countryFlagEmoji(user);
    final titleText =
        user.displayName.isNotEmpty ? user.displayName : user.username;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openMemberProfile(user, globalIndex),
        child: Padding(
          padding: _listCardInnerPadding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.hasBoundedHeight &&
                      constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : _listRowMainAxisExtent;
              return SizedBox(
                height: h,
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: h,
                    height: h,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      fit: StackFit.expand,
                      children: [
                        avatarWidget(
                          user.avatarUrl,
                          context,
                          user.username,
                          disableOnTap: true,
                          size: h,
                        ),
                        _countryFlagOnAvatarCorner(countryFlag),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 12,
                        end: 12,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            titleText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 1.0,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.commentDots,
                                size: 14,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${user.commentCount}',
                                style:
                                    theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                  height: 1.0,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.65),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMembersListOrGrid() {
    final w = MediaQuery.sizeOf(context).width;

    if (_isGridMode) {
      return CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _gridMaxCrossAxisExtent(w),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.62,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildMemberGridTile(_members[index], index),
              childCount: _members.length,
            ),
          ),
          if (_isLoadingMore && _hasMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    }

    /// Listado responsive (como Fitcron): varias columnas si el ancho lo permite.
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 450,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: _listRowMainAxisExtent,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildMemberCard(_members[index], index),
            childCount: _members.length,
          ),
        ),
        if (_isLoadingMore && _hasMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocusGlobal,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${S.current.membersLabel} ($_totalUsers)'),
          actions: [
            IconButton(
              tooltip: _isGridMode
                  ? S.current.viewListLabel
                  : S.current.viewGridLabel,
              icon: Icon(
                _isGridMode
                    ? Icons.view_list_rounded
                    : Icons.grid_view_rounded,
              ),
              onPressed: () {
                unFocusGlobal();
                if (!_disposed) {
                  setState(() => _isGridMode = !_isGridMode);
                  _scheduleFillViewportIfNeeded();
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSearchBar(),
              if (_countryCode != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(_countryCode!),
                      onDeleted: () {
                        unFocusGlobal();
                        setState(() => _countryCode = null);
                        _loadInitial();
                      },
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _loadInitial();
                      if (!_disposed && mounted) {
                        setState(() {});
                      }
                    },
                    child: _isInitialLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _hasError
                            ? ListView(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: emptyDataWidget(
                                      context,
                                      Icons.error_outline_rounded,
                                      S.current.membersErrorLoadTitle,
                                      (_errorDetail != null &&
                                              _errorDetail!.isNotEmpty)
                                          ? _errorDetail!
                                          : S.current.errorAuthGeneric,
                                    ),
                                  ),
                                ],
                              )
                            : _members.isEmpty
                                ? ListView(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        child: emptyDataWidget(
                                          context,
                                          Icons.group_off_rounded,
                                          S.current.membersEmptyTitle,
                                          S.current.membersEmptySubtitle,
                                        ),
                                      ),
                                    ],
                                  )
                                : _buildMembersListOrGrid(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
