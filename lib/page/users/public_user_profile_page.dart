import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/page/messages/private_chat_page.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class PublicUserProfilePage extends StatefulWidget {
  const PublicUserProfilePage({
    super.key,
    required this.username,
    this.initialUser,

    // Modo Fitcron: navegar solo entre los miembros ya cargados en la
    // pantalla de "Members" (sin pedir páginas extra al hacer swipe).
    this.allLoadedMembers,
    this.initialLoadedIndex,

    // Contexto opcional para navegación tipo Fitcron (prev/next) desde el
    // listado de miembros.
    this.navInitialPage,
    this.navInitialIndexInPage,
    this.navInitialPageUsers,
    this.navPerPage,
    this.navSearch,
    this.navCountryCode,
    this.navOrderBy,
    this.navOrder,
    this.navTotalPages,
    this.navTotalUsers,
  });

  final String username;
  final FilmaniakUser? initialUser;

  final List<FilmaniakUser>? allLoadedMembers;
  final int? initialLoadedIndex;

  final int? navInitialPage;
  final int? navInitialIndexInPage;
  final List<FilmaniakUser>? navInitialPageUsers;
  final int? navPerPage;
  final String? navSearch;
  final String? navCountryCode;
  final String? navOrderBy;
  final String? navOrder;
  final int? navTotalPages;
  final int? navTotalUsers;

  @override
  State<PublicUserProfilePage> createState() => _PublicUserProfilePageState();
}

class _PublicUserProfilePageState extends State<PublicUserProfilePage> {
  late String _currentUsername;
  int _currentUserId = 0;
  FilmaniakUser? _user;
  bool _isLoading = false;
  PageController? _profileCarouselController;
  bool _carouselBusy = false;
  int _carouselPageIndex = 0;
  int _profileLoadSeq = 0;

  bool get _useLoadedMembersCarousel =>
      widget.allLoadedMembers != null &&
      widget.allLoadedMembers!.length > 1;

  bool get _navEnabled =>
      widget.navInitialPage != null &&
      widget.navInitialIndexInPage != null &&
      widget.navInitialPageUsers != null &&
      widget.navPerPage != null &&
      widget.navOrderBy != null &&
      widget.navOrder != null;

  late int _navPage;
  late int _navIndexInPage;
  late int _navPerPage;
  late List<FilmaniakUser> _navPageUsers;
  int? _navTotalPages;

  String? _navSearch;
  String? _navCountryCode;
  late String _navOrderBy;
  late String _navOrder;

  Future<void> _showShareOptions(String link, FilmaniakUser user) async {
    if (link.isEmpty) return;
    if (!mounted) return;

    await showShareLinkWithQrBottomSheet(
      context,
      title: S.current.shareTooltip,
      link: link,
      shareSubject: S.current.profileShareSubject(user.username),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentUsername = widget.username;
    _currentUserId = widget.initialUser?.id ?? 0;
    _user = widget.initialUser;
    _isLoading = _user == null;
    if (_navEnabled) {
      _navPage = widget.navInitialPage!;
      _navIndexInPage = widget.navInitialIndexInPage!;
      _navPageUsers = widget.navInitialPageUsers!;
      _navPerPage = widget.navPerPage!;
      _navTotalPages = widget.navTotalPages;
      _navSearch = widget.navSearch;
      _navCountryCode = widget.navCountryCode;
      _navOrderBy = widget.navOrderBy!;
      _navOrder = widget.navOrder!;
    }
    if (_useLoadedMembersCarousel) {
      final total = widget.allLoadedMembers!.length;
      // Igual que Fitcron: el índice correcto es el que viene del listado
      // (posición real del item pulsado), no "reconstruir" buscando por username.
      _carouselPageIndex =
          (widget.initialLoadedIndex ?? 0).clamp(0, total - 1);
      _carouselPageIndex = _carouselPageIndex.clamp(0, total - 1);
      final selected = widget.allLoadedMembers![_carouselPageIndex];
      _currentUsername = selected.username;
      _currentUserId = selected.id;
      _user = selected;
    } else {
      // Usamos un PageView para que el contenido se mueva con el dedo
      // como en Fitcron. El índice actual lo mantenemos estable para que,
      // si cambia itemCount (primer/último), no nos quedemos en un slot que
      // ya no existe.
      _carouselPageIndex = _carouselItemCount == 3
          ? 1
          : (_canPrev ? 1 : 0); // itemCount==2 => prev existe? (último) =>1 :0
    }

    _profileCarouselController =
        PageController(initialPage: _carouselPageIndex);
    // En modo Fitcron queremos comportamiento idéntico: cargar siempre
    // el perfil completo (no solo el "summary" que trae el listado).
    _loadUser(force: _useLoadedMembersCarousel);
  }

  bool get _canPrev {
    if (!_navEnabled) return false;
    if (_navPage <= 1 && _navIndexInPage <= 0) return false;
    return _navIndexInPage > 0 || _navPage > 1;
  }

  bool get _canNext {
    if (!_navEnabled) return false;
    final hasNextInPage = _navIndexInPage + 1 < _navPageUsers.length;
    if (hasNextInPage) return true;
    if (_navTotalPages != null && _navTotalPages! > 0) {
      return _navPage < _navTotalPages!;
    }
    return _navPageUsers.length >= _navPerPage;
  }

  // Fitcron no deja deslizar más si estás en el primero/último.
  // Para imitarlo, el PageView en móvil tiene solo las páginas "reales":
  // - 3 slots si existen prev y next
  // - 2 slots si solo existe uno de los lados
  // - 1 slot si no existe ninguno
  int get _carouselItemCount {
    if (_useLoadedMembersCarousel) return widget.allLoadedMembers!.length;
    if (!_navEnabled) return 1;
    if (!_canPrev && !_canNext) return 1;
    if (_canPrev && _canNext) return 3;
    return 2;
  }

  Future<void> _loadUser({required bool force}) async {
    // El endpoint /users devuelve solo un "summary" (sin descripción completa).
    // Por eso, si venimos con contexto de navegación (_navEnabled), siempre
    // cargamos el perfil completo.
    if (!force && _user != null && !_navEnabled) {
      setState(() => _isLoading = false);
      return;
    }

    final loadSeq = ++_profileLoadSeq;

    setState(() {
      _isLoading = true;
    });

    final FilmaniakUser? user = _useLoadedMembersCarousel && _currentUserId > 0
        ? await FilmaniakApi.getPublicUserById(_currentUserId)
        : await FilmaniakApi.getPublicUserByUsername(_currentUsername);
    if (!mounted) return;
    if (loadSeq != _profileLoadSeq) {
      // Se disparó un load más nuevo antes de terminar este.
      return;
    }

    setState(() {
      _user = user ?? _user;
      _isLoading = false;
    });
  }

  Future<void> _goPrev() async {
    if (!_navEnabled || _isLoading || !_canPrev) return;

    // Dentro de la misma página.
    if (_navIndexInPage > 0) {
      setState(() => _navIndexInPage--);
      _currentUsername = _navPageUsers[_navIndexInPage].username;
      _currentUserId = _navPageUsers[_navIndexInPage].id;
      await _loadUser(force: true);
      return;
    }

    // Página anterior.
    final newPage = _navPage - 1;
    final result = await FilmaniakApi.getMembers(
      page: newPage,
      perPage: _navPerPage,
      search: _navSearch,
      country: _navCountryCode,
      orderBy: _navOrderBy,
      order: _navOrder,
    );
    if (!mounted) return;
    if (result['error'] == true) return;

    final posts = (result['users'] as List<FilmaniakUser>? ?? <FilmaniakUser>[]);
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    _navTotalPages = (pagination['totalPages'] as num?)?.toInt() ?? _navTotalPages;

    setState(() {
      _navPage = newPage;
      _navPageUsers = posts;
      _navIndexInPage = posts.isNotEmpty ? posts.length - 1 : 0;
      _currentUsername =
          posts.isNotEmpty ? posts[_navIndexInPage].username : _currentUsername;
      _currentUserId = posts.isNotEmpty ? posts[_navIndexInPage].id : _currentUserId;
    });
    await _loadUser(force: true);
  }

  Future<void> _goNext() async {
    if (!_navEnabled || _isLoading || !_canNext) return;

    // Dentro de la misma página.
    if (_navIndexInPage + 1 < _navPageUsers.length) {
      setState(() => _navIndexInPage++);
      _currentUsername = _navPageUsers[_navIndexInPage].username;
      _currentUserId = _navPageUsers[_navIndexInPage].id;
      await _loadUser(force: true);
      return;
    }

    // Página siguiente.
    final newPage = _navPage + 1;
    final result = await FilmaniakApi.getMembers(
      page: newPage,
      perPage: _navPerPage,
      search: _navSearch,
      country: _navCountryCode,
      orderBy: _navOrderBy,
      order: _navOrder,
    );
    if (!mounted) return;
    if (result['error'] == true) return;

    final posts = (result['users'] as List<FilmaniakUser>? ?? <FilmaniakUser>[]);
    final pagination = result['pagination'] as Map<String, dynamic>? ?? {};
    _navTotalPages = (pagination['totalPages'] as num?)?.toInt() ?? _navTotalPages;

    setState(() {
      _navPage = newPage;
      _navPageUsers = posts;
      _navIndexInPage = posts.isNotEmpty ? 0 : 0;
      _currentUsername =
          posts.isNotEmpty ? posts[_navIndexInPage].username : _currentUsername;
      _currentUserId = posts.isNotEmpty ? posts[_navIndexInPage].id : _currentUserId;
    });
    await _loadUser(force: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(S.current.publicProfileAppBarTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_off_rounded, size: 56),
                const SizedBox(height: 12),
                Text(
                  S.current.userNotFoundPublicProfileText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _loadUser(force: true),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(S.current.retryPublicProfile),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final user = _user!;
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 650;
    final bool useLoadedMembersCarousel = _useLoadedMembersCarousel;
    final int membersTotalUsers = useLoadedMembersCarousel
        ? widget.allLoadedMembers!.length
        : (widget.navTotalUsers ?? 0);
    final int? membersCurrentIndex = useLoadedMembersCarousel
        ? (_carouselPageIndex + 1)
        : (_navEnabled
            ? ((_navPage - 1) * _navPerPage + _navIndexInPage + 1)
            : null);
    final bool showMembersCounterChip =
        (membersTotalUsers > 0) && membersCurrentIndex != null;

    // Como Fitcron, en móvil el swipe manda; en escritorio mostramos flechas.
    final bool showNavButtons = (useLoadedMembersCarousel ? width > 800 : _navEnabled) &&
        !isMobile;
    final publicUrl = FilmaniakApi.buildPublicProfileUrl(user.username);
    final website = user.websiteUrl.trim();
    final fullName = [user.firstName, user.lastName]
        .where((e) => e.trim().isNotEmpty)
        .join(' ')
        .trim();

    final lastLoginText = user.lastLogin.isNotEmpty
        ? _formatDateForUser(user.lastLogin, user.dateFormat)
        : '';

    final countryFlag = _tryCountryFlag(user.country);
    final ageLine = user.birthdate.isNotEmpty
        ? '${formatAgeFromBirthday(user.birthdate)} ${S.current.userYears}'
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoading ? S.current.loading : user.username),
        actions: [
          if (showMembersCounterChip)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: Text(
                '$membersCurrentIndex / $membersTotalUsers',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
            ),
          if (showNavButtons)
            IconButton(
              tooltip: S.current.previousLabel,
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: !_isLoading
                  ? (useLoadedMembersCarousel
                      ? (_carouselPageIndex > 0
                          ? () {
                              _profileCarouselController!.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null)
                      : (_canPrev ? () => _goPrev() : null))
                  : null,
            ),
          if (showNavButtons)
            IconButton(
              tooltip: S.current.nextLabel,
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: !_isLoading
                  ? (useLoadedMembersCarousel
                      ? (_carouselPageIndex + 1 < membersTotalUsers
                          ? () {
                              _profileCarouselController!.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null)
                      : (_canNext ? () => _goNext() : null))
                  : null,
            ),
          if (user.id != globalCurrentUser.id)
            IconButton(
              tooltip: S.current.sendMessageTooltip,
              icon: const Icon(Icons.mail_outline_rounded),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PrivateChatPage(
                    recipientId: user.id,
                    recipientUsername: user.username,
                    recipientAvatarUrl: user.avatarUrl,
                  ),
                ),
              ),
            ),
          IconButton(
            tooltip: S.current.shareTooltip,
            onPressed: publicUrl.isEmpty
                ? null
                : () => _showShareOptions(publicUrl, user),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _profileCarouselController!,
        itemCount: _carouselItemCount,
        physics: _carouselItemCount > 1
            ? const PageScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => _onProfileCarouselPageChanged(index),
        itemBuilder: (context, index) {
          if (index == _carouselPageIndex) {
            if (_isLoading) {
              return _buildProfileCarouselPlaceholder();
            }
            return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => _loadUser(force: true),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _isLoading ? 0.65 : 1.0,
                  child: ListView(
                key: ValueKey(user.username),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                children: [
            // Header tipo Letterboxd: avatar + nombre + detalles compactos.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatarWidget(
                  user.avatarUrl,
                  context,
                  user.username,
                  size: 80,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.displayName.isNotEmpty ||
                          countryFlag.isNotEmpty) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (user.displayName.isNotEmpty)
                              Flexible(
                                child: Text(
                                  user.displayName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (countryFlag.isNotEmpty)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: user.displayName.isNotEmpty ? 8 : 0,
                                  top: 0,
                                ),
                                child: Tooltip(
                                  message: _tryCountryTooltip(context, user.country),
                                  child: Text(
                                    countryFlag,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                      if (ageLine.isNotEmpty)
                        Text(
                          ageLine,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      if (lastLoginText.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${S.current.lastAccessChipPrefix}: $lastLoginText',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      if (fullName.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          fullName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      // (Mantenemos el perfil simple: país como bandera, edad y último acceso como líneas.)
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),
            if (user.description.trim().isNotEmpty) ...[
              Text(
                S.current.bioLabel,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Html(
                data: user.description.trim(),
                style: {
                  'body': Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    fontSize: FontSize(14),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  'a': Style(
                    color: Theme.of(context).colorScheme.primary,
                    textDecoration: TextDecoration.underline,
                  ),
                },
                onLinkTap: (url, _, _) async {
                  final uri = Uri.tryParse(url ?? '');
                  if (uri == null) return;
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
              ),
              const SizedBox(height: 18),
            ],

            if (website.isNotEmpty) ...[
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final uri = Uri.tryParse(website);
                  if (uri == null) return;
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.public_rounded,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.webBlogLabel,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              website,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.open_in_new_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],

            const SizedBox(height: 6),
                  ],
                  ),
                ),
              ),
            if (_isLoading)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withValues(
                          alpha: 0.15,
                        ),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
            );
          }
          return _buildProfileCarouselPlaceholder();
        },
      ),
    );
  }

  Future<void> _onProfileCarouselPageChanged(int index) async {
    if (index == _carouselPageIndex) return;
    if (index < 0 || index >= _carouselItemCount) return;

    // Modo Fitcron: permite swipes encadenados incluso si todavía está cargando.
    if (_useLoadedMembersCarousel) {
      final members = widget.allLoadedMembers!;
      setState(() {
        _carouselPageIndex = index;
        _currentUsername = members[index].username;
        _currentUserId = members[index].id;
      });

      // Fitcron: simplemente recargamos para el índice actual.
      // El guard con `_profileLoadSeq` evita que respuestas viejas
      // se apliquen después.
      await _loadUser(force: true);
      return;
    }

    // Modo paginado clásico (prev/next via API).
    if (_carouselBusy || _isLoading) return;

    _carouselBusy = true;
    try {
      final prevIndex = _carouselPageIndex;
      setState(() {
        _carouselPageIndex = index;
      });

      if (index < prevIndex) {
        await _goPrev();
      } else {
        await _goNext();
      }
    } finally {
      _carouselBusy = false;
    }

    if (!mounted) return;
    final maxIndex = _carouselItemCount - 1;
    if (_carouselPageIndex > maxIndex) {
      setState(() {
        _carouselPageIndex = maxIndex.clamp(0, _carouselItemCount - 1);
      });
    }
  }

  Widget _buildProfileCarouselPlaceholder() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(strokeWidth: 2),
            const SizedBox(height: 12),
            Text(S.current.loading),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _profileCarouselController?.dispose();
    super.dispose();
  }

  String _formatDateForUser(String input, String dateFormat) {
    try {
      final normalized = input.replaceAll(' ', 'T');
      final dt = DateTime.tryParse(normalized);
      if (dt == null) return input;
      if (dateFormat.trim().isEmpty) return input;
      return DateFormat(dateFormat).format(dt);
    } catch (_) {
      return input;
    }
  }

  String _tryCountryFlag(String countryCode) {
    if (countryCode.trim().isEmpty) return '';
    try {
      return Country.parse(countryCode).flagEmoji;
    } catch (_) {
      return '';
    }
  }

  String _tryCountryTooltip(BuildContext context, String countryCode) {
    final code = countryCode.trim();
    if (code.isEmpty) return '';
    try {
      final country = Country.parse(code);
      return country.getTranslatedName(context) ?? country.displayNameNoCountryCode;
    } catch (_) {
      return code.toUpperCase();
    }
  }
}
