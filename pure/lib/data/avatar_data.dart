/// Mock avatar URLs for chat profiles
class AvatarData {
  // List of portrait images from unsplash
  static const List<String> mockAvatarUrls = [
    'assets/images/avatar.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
    'assets/images/avatar4.jpg',
    'assets/images/avatar5.jpg',
    'assets/images/avatar6.jpg',
  ];

  /// Get avatar URL by index
  static String getAvatarUrl(int index) {
    return mockAvatarUrls[index % mockAvatarUrls.length];
  }
}
