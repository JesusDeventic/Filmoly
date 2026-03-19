import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/private_message_model.dart';
import 'package:filmoly/page/messages/private_chat_page.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivateConversationsPage extends StatefulWidget {
  const PrivateConversationsPage({super.key});

  @override
  State<PrivateConversationsPage> createState() => _PrivateConversationsPageState();
}

class _PrivateConversationsPageState extends State<PrivateConversationsPage> {
  final List<Conversation> _conversations = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  static const int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool refresh = true}) async {
    if (refresh) {
      setState(() { _loading = true; _conversations.clear(); _hasMore = true; });
    }
    final result = await FilmolyApi.getConversations(limit: _pageSize, offset: 0);
    if (!mounted) return;
    setState(() {
      _conversations.addAll(result);
      _hasMore = result.length >= _pageSize;
      _loading = false;
    });
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    final result = await FilmolyApi.getConversations(
      limit: _pageSize, offset: _conversations.length);
    if (!mounted) return;
    setState(() {
      _conversations.addAll(result);
      _hasMore = result.length >= _pageSize;
      _loadingMore = false;
    });
  }

  void _openChat(Conversation conv) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          recipientId: conv.otherUser.id,
          recipientUsername: conv.otherUser.username,
          recipientAvatarUrl: conv.otherUser.avatarUrl,
        ),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.privateMessages),
        centerTitle: false,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _conversations.isEmpty
              ? Center(child: Text(S.current.messagesEmpty))
              : RefreshIndicator(
                  onRefresh: () => _load(),
                  child: ListView.builder(
                    itemCount: _conversations.length + (_hasMore ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (i == _conversations.length) {
                        _loadMore();
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return _ConversationTile(
                        conv: _conversations[i],
                        onTap: () => _openChat(_conversations[i]),
                      );
                    },
                  ),
                ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conv;
  final VoidCallback onTap;

  const _ConversationTile({required this.conv, required this.onTap});

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return DateFormat.Hm().format(dt);
    if (diff.inDays == 1) return 'Ayer';
    if (diff.inDays < 7) return DateFormat.E().format(dt);
    return DateFormat.yMd().format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final last = conv.lastMessage;
    final preview = last.isDeleted
        ? S.current.messagesDeleted
        : (last.content ?? '');

    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          userAvatar(
            context,
            avatarUrl: conv.otherUser.avatarUrl,
            username: conv.otherUser.username,
            size: 48,
          ),
          if (conv.hasUnread)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        conv.otherUser.username,
        style: TextStyle(
          fontWeight: conv.hasUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        preview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontStyle: last.isDeleted ? FontStyle.italic : FontStyle.normal,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Text(
        _formatTime(last.createdAt),
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      onTap: onTap,
    );
  }
}
