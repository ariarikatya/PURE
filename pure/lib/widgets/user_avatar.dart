import 'package:flutter/material.dart';
import '../data/avatar_data.dart';

class UserAvatar extends StatelessWidget {
  final int index;
  final double radius;
  final String? fallbackInitial;

  const UserAvatar({
    super.key,
    required this.index,
    this.radius = 28,
    this.fallbackInitial,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = AvatarData.getAvatarUrl(index);
    return Container(
      width: radius * 2,
      height: radius * 2,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            if (fallbackInitial != null && fallbackInitial!.isNotEmpty) {
              return Container(
                color: Colors.grey[800],
                alignment: Alignment.center,
                child: Text(
                  fallbackInitial!,
                  style: TextStyle(fontSize: radius * 0.8, color: Colors.white),
                ),
              );
            }
            return Container(color: Colors.grey[800]);
          },
        ),
      ),
    );
  }
}
