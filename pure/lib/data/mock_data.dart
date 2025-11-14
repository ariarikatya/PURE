import '../models/chat.dart';
import '../models/chat_message.dart';

class MockData {
  static final List<Chat> chats = [
    Chat(
      id: '1',
      userName: 'Отлично выглядишь',
      userAvatar: '👤',
      lastMessage: 'Отлично выглядишь',
      timestamp: '23 ч 43 мин',
      hasUnread: false,
    ),
    Chat(
      id: '2',
      userName: 'Встретимся? Я рядом',
      userAvatar: '👤',
      lastMessage: 'Встретимся? Я рядом',
      timestamp: '20 ч 40 мин',
      hasUnread: false,
    ),
    Chat(
      id: '3',
      userName: 'Встретимся?',
      userAvatar: '👤',
      lastMessage: 'Встретимся?',
      timestamp: '18 ч 40 мин',
      hasUnread: false,
    ),
    Chat(
      id: '4',
      userName: 'Давно тебя хочу',
      userAvatar: '👤',
      lastMessage: 'Давно тебя хочу',
      timestamp: '09 ч 40 мин',
      hasUnread: false,
    ),
    Chat(
      id: '5',
      userName: 'Я в ванной.. Скинь фото...',
      userAvatar: '👤',
      lastMessage: 'Я в ванной.. Скинь фото...',
      timestamp: '03 ч 04 мин',
      hasUnread: false,
    ),
    Chat(
      id: '6',
      userName: 'Привет',
      userAvatar: '👤',
      lastMessage: 'Привет',
      timestamp: '01 ч 09 мин',
      hasUnread: false,
    ),
  ];

  static List<ChatMessage> getMessagesForChat(String chatId) {
    return [
      ChatMessage(
        id: '1',
        senderId: chatId,
        text: 'Привет! Как дела?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: false,
      ),
      ChatMessage(
        id: '2',
        senderId: 'me',
        text: 'Привет! Всё отлично, спасибо!',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 50),
        ),
        isMe: true,
      ),
      ChatMessage(
        id: '3',
        senderId: chatId,
        text: 'Рад слышать! Что делаешь?',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 30),
        ),
        isMe: false,
      ),
    ];
  }
}
