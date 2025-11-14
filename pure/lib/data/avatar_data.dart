/// Mock avatar URLs for chat profiles
class AvatarData {
  // List of portrait images from unsplash
  static const List<String> mockAvatarUrls = [
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1506749410340-ce612decc67d?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1519345291146-c6142a89feb3?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1534308143481-c55f00be8e56?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1539571696357-5a69c006ae91?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1517070213202-1d387cabebb3?w=200&h=200&fit=crop',
  ];

  /// Get avatar URL by index
  static String getAvatarUrl(int index) {
    return mockAvatarUrls[index % mockAvatarUrls.length];
  }
}
