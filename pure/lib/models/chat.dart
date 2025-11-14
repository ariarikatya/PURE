class Chat {
  final String id;
  final String userName;
  final String userAvatar;
  final String lastMessage;
  final String timestamp;
  final bool hasUnread;

  Chat({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.lastMessage,
    required this.timestamp,
    this.hasUnread = false,
  });
}
