import 'dart:async';

import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/private_message_model.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivateChatPage extends StatefulWidget {
  final int recipientId;
  final String recipientUsername;
  final String recipientAvatarUrl;

  const PrivateChatPage({
    super.key,
    required this.recipientId,
    required this.recipientUsername,
    required this.recipientAvatarUrl,
  });

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final List<PrivateMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _refreshTimer;

  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  bool _sending = false;
  bool? _lastMsgRead;

  // Cursor para el polling delta
  String? _lastCreatedAt;

  // Estado de edición
  PrivateMessage? _editingMessage;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _startPolling();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // =========================================================
  // CARGA
  // =========================================================

  Future<void> _loadInitial() async {
    setState(() => _loading = true);
    final msgs = await FilmolyApi.getMessages(otherUserId: widget.recipientId);
    if (!mounted) return;
    setState(() {
      _messages.clear();
      _messages.addAll(msgs);
      _hasMore = msgs.length >= 50;
      _updateCursor();
      _loading = false;
    });
    _refreshReadStatus();
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore || _messages.isEmpty) return;
    setState(() => _loadingMore = true);
    final oldest = _messages.last.id;
    final msgs = await FilmolyApi.getMessages(
      otherUserId: widget.recipientId, beforeId: oldest);
    if (!mounted) return;
    setState(() {
      _messages.addAll(msgs);
      _hasMore = msgs.length >= 50;
      _loadingMore = false;
    });
  }

  // =========================================================
  // POLLING (5 segundos)
  // =========================================================

  void _startPolling() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        _pollDelta();
        _refreshReadStatus();
      }
    });
  }

  Future<void> _pollDelta() async {
    if (_lastCreatedAt == null) return;
    final delta = await FilmolyApi.getMessages(
      otherUserId: widget.recipientId, afterCreated: _lastCreatedAt);
    if (!mounted || delta.isEmpty) return;

    setState(() {
      for (final incoming in delta) {
        final idx = _messages.indexWhere((m) => m.id == incoming.id);
        if (idx >= 0) {
          _messages[idx] = incoming;
        } else {
          _messages.insert(0, incoming);
        }
      }
      _updateCursor();
    });
  }

  Future<void> _refreshReadStatus() async {
    final isRead = await FilmolyApi.getMessageReadStatus(widget.recipientId);
    if (!mounted) return;
    setState(() => _lastMsgRead = isRead);
  }

  void _updateCursor() {
    if (_messages.isEmpty) return;
    DateTime latest = _messages.first.latestTimestamp;
    for (final m in _messages) {
      if (m.latestTimestamp.isAfter(latest)) latest = m.latestTimestamp;
    }
    _lastCreatedAt = latest.toUtc().toIso8601String();
  }

  // =========================================================
  // ENVIAR / EDITAR
  // =========================================================

  Future<void> _submit() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _sending) return;

    if (_editingMessage != null) {
      await _confirmEdit(text);
    } else {
      await _sendNew(text);
    }
  }

  Future<void> _sendNew(String text) async {
    setState(() => _sending = true);
    _inputController.clear();
    final msg = await FilmolyApi.sendMessage(
      recipientId: widget.recipientId, message: text);
    if (!mounted) return;
    setState(() {
      _sending = false;
      if (msg != null) {
        _messages.insert(0, msg);
        _updateCursor();
      } else {
        showCustomSnackBar(S.current.messagesErrorSend, type: -1);
      }
    });
  }

  Future<void> _confirmEdit(String text) async {
    final msg = _editingMessage!;
    setState(() { _sending = true; _editingMessage = null; });
    _inputController.clear();
    final ok = await FilmolyApi.editMessage(id: msg.id, message: text);
    if (!mounted) return;
    setState(() => _sending = false);
    if (!ok) showCustomSnackBar(S.current.messagesErrorEdit, type: -1);
  }

  void _startEdit(PrivateMessage msg) {
    setState(() => _editingMessage = msg);
    _inputController.text = msg.message ?? '';
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: _inputController.text.length));
  }

  void _cancelEdit() {
    setState(() => _editingMessage = null);
    _inputController.clear();
  }

  Future<void> _deleteMessage(PrivateMessage msg) async {
    final ok = await FilmolyApi.deleteMessage(msg.id);
    if (!mounted) return;
    if (!ok) {
      showCustomSnackBar(S.current.messagesErrorDelete, type: -1);
    }
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            userAvatar(
              context,
              avatarUrl: widget.recipientAvatarUrl,
              username: widget.recipientUsername,
              size: 36,
            ),
            const SizedBox(width: 10),
            Text(widget.recipientUsername),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(child: Text(S.current.messagesNoMessages))
                    : NotificationListener<ScrollNotification>(
                        onNotification: (n) {
                          if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
                            _loadMore();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          itemCount: _messages.length + (_loadingMore ? 1 : 0),
                          itemBuilder: (ctx, i) {
                            if (i == _messages.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final msg = _messages[i];
                            final isMe = msg.senderId == globalCurrentUser.id;
                            final isLast = i == 0;
                            return _MessageBubble(
                              msg: msg,
                              isMe: isMe,
                              showReadStatus: isMe && isLast && _lastMsgRead != null,
                              isRead: _lastMsgRead,
                              onLongPress: isMe && !msg.isDeleted
                                  ? () => _showMessageMenu(ctx, msg)
                                  : null,
                            );
                          },
                        ),
                      ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_editingMessage != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _editingMessage!.message ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: _cancelEdit,
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: S.current.messagesTypeHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _sending
                    ? const SizedBox(
                        width: 42,
                        height: 42,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton.filled(
                        icon: Icon(_editingMessage != null
                            ? Icons.check_rounded
                            : Icons.send_rounded),
                        onPressed: _submit,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageMenu(BuildContext ctx, PrivateMessage msg) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(S.current.messagesEdit),
              onTap: () {
                Navigator.pop(context);
                _startEdit(msg);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error),
              title: Text(S.current.messagesDelete,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(msg);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(PrivateMessage msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.current.messagesDelete),
        content: Text(S.current.messagesDeleteConfirm),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(S.current.buttonCancel),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _deleteMessage(msg);
                  },
                  child: Text(S.current.buttonConfirm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================
// BURBUJA DE MENSAJE
// =========================================================

class _MessageBubble extends StatelessWidget {
  final PrivateMessage msg;
  final bool isMe;
  final bool showReadStatus;
  final bool? isRead;
  final VoidCallback? onLongPress;

  const _MessageBubble({
    required this.msg,
    required this.isMe,
    required this.showReadStatus,
    this.isRead,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bgColor = isMe ? scheme.primary : scheme.surfaceContainerHighest;
    final fgColor = isMe ? scheme.onPrimary : scheme.onSurface;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: msg.isDeleted
                ? scheme.surfaceContainerHighest.withValues(alpha: 0.5)
                : bgColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 16),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (msg.isDeleted)
                Text(
                  S.current.messagesDeleted,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: fgColor.withValues(alpha: 0.55),
                    fontSize: 14,
                  ),
                )
              else
                Text(
                  msg.message ?? '',
                  style: TextStyle(color: fgColor, fontSize: 15),
                ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat.Hm().format(msg.createdAt.toLocal()),
                    style: TextStyle(
                      fontSize: 11,
                      color: fgColor.withValues(alpha: 0.6),
                    ),
                  ),
                  if (msg.isEdited && !msg.isDeleted) ...[
                    const SizedBox(width: 4),
                    Text(
                      S.current.messagesEdited,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: fgColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                  if (showReadStatus && isRead != null) ...[
                    const SizedBox(width: 4),
                    Icon(
                      isRead! ? Icons.done_all_rounded : Icons.done_rounded,
                      size: 14,
                      color: isRead!
                          ? Colors.lightBlueAccent
                          : fgColor.withValues(alpha: 0.6),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
