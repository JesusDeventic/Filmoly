import 'package:country_picker/country_picker.dart';
import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/page/users/public_user_profile_page.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';

class MembersListPage extends StatefulWidget {
  const MembersListPage({super.key});

  @override
  State<MembersListPage> createState() => _MembersListPageState();
}

class _MembersListPageState extends State<MembersListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final int _perPage = 24;
  String _searchText = '';
  String? _countryCode;
  String _selectedOrder = 'registered_desc';

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
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMore && !_isLoadingMore && !_disposed) {
        _loadMore();
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
    setState(() {
      _searchController.clear();
      _searchText = '';
    });
    _loadInitial();
  }

  void _openFilterSheet() {
    showDraggableAppSheet(
      context,
      title: 'Filtros',
      titleFontSize: 18,
      intrinsicHeight: true,
      bodyBuilder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedOrder,
              decoration: const InputDecoration(
                labelText: 'Ordenar por',
                prefixIcon: Icon(Icons.sort_rounded),
              ),
              items: const [
                DropdownMenuItem(value: 'name_asc', child: Text('Nombre (A-Z)')),
                DropdownMenuItem(value: 'name_desc', child: Text('Nombre (Z-A)')),
                DropdownMenuItem(value: 'age_asc', child: Text('Edad (joven a mayor)')),
                DropdownMenuItem(value: 'age_desc', child: Text('Edad (mayor a joven)')),
                DropdownMenuItem(
                    value: 'registered_asc',
                    child: Text('Registro (mas antiguo primero)')),
                DropdownMenuItem(
                    value: 'registered_desc',
                    child: Text('Registro (mas reciente primero)')),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() => _selectedOrder = v);
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.flag_rounded),
              title: Text(
                _countryCode == null
                    ? 'Pais'
                    : 'Pais: ${Country.parse(_countryCode!).displayNameNoCountryCode}',
              ),
              subtitle: _countryCode == null
                  ? const Text('Todos')
                  : Text('Código: $_countryCode'),
              trailing: _countryCode == null
                  ? const Icon(Icons.chevron_right_rounded)
                  : IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () => setState(() => _countryCode = null),
                    ),
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (country) {
                    setState(() => _countryCode = country.countryCode);
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
                      setState(() {
                        _selectedOrder = 'registered_desc';
                        _countryCode = null;
                      });
                      Navigator.of(context).pop();
                      _loadInitial();
                    },
                    child: Text(S.current.actionNo),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _loadInitial();
                    },
                    child: Text(S.current.actionYes),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar miembro...',
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
          const SizedBox(width: 6),
          IconButton(
            onPressed: _openFilterSheet,
            icon: const Icon(Icons.filter_alt_rounded),
            tooltip: 'Filtros',
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              onPressed: _applySearch,
              icon: const Icon(Icons.check_rounded),
              tooltip: 'Aplicar busqueda',
            ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(FilmaniakUser user) {
    final age = formatAgeFromBirthday(user.birthdate);
    final countryFlag = user.country.isNotEmpty
        ? Country.tryParse(user.country)?.flagEmoji ?? ''
        : '';
    return Card(
      child: ListTile(
        leading: avatarWidget(
          user.avatarUrl,
          context,
          user.username,
          disableOnTap: true,
          size: 48,
        ),
        title: Text(
          user.displayName.isNotEmpty ? user.displayName : user.username,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '@${user.username}${countryFlag.isNotEmpty ? '  $countryFlag' : ''}${age != '?' ? '  ·  $age ${S.current.userYears}' : ''}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PublicUserProfilePage(username: user.username),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocusGlobal,
      child: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('Miembros: $_totalUsers'),
                const SizedBox(width: 8),
                if (_countryCode != null)
                  Chip(
                    label: Text(_countryCode!),
                    onDeleted: () {
                      setState(() => _countryCode = null);
                      _loadInitial();
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadInitial,
              child: _isInitialLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _hasError
                      ? ListView(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: emptyDataWidget(
                                context,
                                Icons.error_outline_rounded,
                                'No se pudo cargar el directorio',
                                (_errorDetail != null && _errorDetail!.isNotEmpty)
                                    ? _errorDetail!
                                    : 'Revisa la conexión o vuelve a intentarlo. Si acabas de actualizar la app, despliega también el PHP en WordPress (endpoint /users).',
                              ),
                            ),
                          ],
                        )
                      : _members.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  child: emptyDataWidget(
                                    context,
                                    Icons.group_off_rounded,
                                    'No hay miembros',
                                    'Prueba con otra búsqueda o filtros.',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: _members.length + (_hasMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= _members.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return _buildMemberCard(_members[index]);
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }
}
