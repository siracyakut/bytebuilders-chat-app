class People {
  final String name;
  final String avatarUrl;
  String lastMessage;
  String dateTime;
  int unreadCount;

  People({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.dateTime,
    required this.unreadCount,
  });
}
