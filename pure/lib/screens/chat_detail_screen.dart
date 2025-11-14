import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../models/chat.dart';
import '../models/chat_message.dart';
import '../widgets/user_avatar.dart';
import '../widgets/svg_icons.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;
  final int avatarIndex;

  const ChatDetailScreen({super.key, required this.chat, this.avatarIndex = 0});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool _showEmojiPanel = false;

  void _startVoiceRecording() {
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: 'me',
          text: '🎤 Голосовое сообщение (мок)',
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
    });
    debugPrint('Начата запись голосового сообщения');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Голосовое сообщение отправлено (мок)')),
    );
  }

  void _toggleEmojiPanel() {
    setState(() {
      _showEmojiPanel = !_showEmojiPanel;
    });
  }

  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(MockData.getMessagesForChat(widget.chat.id));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: 'me',
          text: _messageController.text,
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
    });

    _messageController.clear();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              senderId: 'me',
              text:
                  result.files.first.extension == 'mp4' ||
                      result.files.first.extension == 'mov'
                  ? '🎬 ${result.files.first.name}'
                  : '🖼️ ${result.files.first.name}',
              timestamp: DateTime.now(),
              isMe: true,
            ),
          );
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple banner positioned at 82px from top
        Positioned(
          top: 82,
          left: 0,
          right: 0,
          child: Container(
            height: 68,
            width: double.infinity,
            color: AppColors.purple,
            child: Row(
              children: [
                const SizedBox(width: 32),
                Image.asset(
                  'assets/images/rocket.png',
                  height: 36,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                const Text(
                  '2 общих соблазна',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
        // Main content with margin from top
        Container(
          margin: EdgeInsets.only(
            top: 82 + 68 + 16, // 82px offset + 68px banner + 16px spacing
          ),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: AppColors.divider, width: 1),
              bottom: BorderSide(color: AppColors.divider, width: 1),
              left: BorderSide(color: AppColors.divider, width: 1),
              right: BorderSide(color: AppColors.divider, width: 1),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header with back button and avatar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    UserAvatar(
                      index: widget.avatarIndex,
                      radius: 20,
                      fallbackInitial: widget.chat.userAvatar,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.chat.userName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Messages area
              Expanded(
                child: Container(
                  color: AppColors.cardBackground,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_messages.isEmpty)
                        const Text(
                          'Начни общение',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 18,
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              return _MessageBubble(message: _messages[index]);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Message input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                    top: BorderSide(color: AppColors.divider, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: _pickFile,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Сообщение...',
                                      hintStyle: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (_) => _sendMessage(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _toggleEmojiPanel,
                                  child: Image.asset(
                                    'assets/images/chat.png',
                                    height: 23,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: _startVoiceRecording,
                        ),
                      ],
                    ),
                    if (_showEmojiPanel)
                      Container(
                        height: 200,
                        color: Colors.white,
                        child: const Center(
                          child: Text('Панель эмодзи и стикеров (заглушка)'),
                        ),
                      ),
                  ],
                ),
              ),
              // Bottom SafeArea with background color
              Container(
                height: MediaQuery.of(context).padding.bottom,
                color: AppColors.background,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: message.isMe
                  ? AppColors.messageMyBubble
                  : AppColors.messageOtherBubble,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
