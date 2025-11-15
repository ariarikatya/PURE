import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../models/chat.dart';
import '../models/chat_message.dart';
import '../widgets/user_avatar.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;
  final int avatarIndex;

  const ChatDetailScreen({super.key, required this.chat, this.avatarIndex = 0});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool _showEmojiPanel = false;
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

  void _toggleEmojiPanel() {
    setState(() {
      _showEmojiPanel = !_showEmojiPanel;
    });
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Голосовое сообщение отправлено (мок)')),
    );
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null) {
        final file = result.files.first;

        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              senderId: 'me',
              text: (file.extension == 'mp4' || file.extension == 'mov')
                  ? '🎬 ${file.name}'
                  : '🖼️ ${file.name}',
              timestamp: DateTime.now(),
              isMe: true,
            ),
          );
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Верхний блок: стрелка, аватар, три точки
          SafeArea(
            top: true,
            bottom: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textPrimary,
                    ), // цвет textPrimary
                    onPressed: () => Navigator.pop(context),
                  ),
                  UserAvatar(
                    index: widget.avatarIndex,
                    radius: 20,
                    fallbackInitial: widget.chat.userAvatar,
                  ),
                  const Spacer(),
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
          ),

          const SizedBox(height: 47), // отступ до фиолетового баннера
          // Фиолетовый баннер с картинкой и крестиком
          Container(
            height: 39,
            width: double.infinity,
            color: AppColors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/rocket.png',
                  height: 24,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '2 общих соблазна',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // отступ снизу баннера
          // Чат
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: AppColors.background),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColors.cardBackground,
                      child: _messages.isEmpty
                          ? const Center(
                              child: Text(
                                'Начни общение',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _messages.length,
                              itemBuilder: (context, i) =>
                                  _MessageBubble(message: _messages[i]),
                            ),
                    ),
                  ),
                  // Ввод сообщений
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      border: Border(
                        top: BorderSide(color: AppColors.divider, width: 1),
                      ),
                    ),
                    child: Row(
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
                  ),
                  Container(
                    height: MediaQuery.of(context).padding.bottom,
                    color: AppColors.background,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
