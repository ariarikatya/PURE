import 'package:flutter/material.dart';
import 'package:pure/constants/app_colors.dart';
import 'package:pure/data/mock_data.dart';
import 'package:pure/models/chat.dart';
import 'package:pure/screens/chat_detail_screen.dart';
import 'package:pure/screens/incognito_mode_screen.dart';
import 'package:pure/widgets/svg_icons.dart';
import 'package:pure/widgets/user_avatar.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool isIncognitoMode = false;

  void _toggleIncognitoMode() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => IncognitoModeScreen(
        onClose: () => Navigator.pop(context),
        onPurchase: () {
          Navigator.pop(context);
          setState(() {
            isIncognitoMode = true;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            // Top empty area
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 135,
              child: Container(),
            ),

            // Bottom panel
            Positioned(
              top: 135,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'ЧАТЫ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Text(
                                'OFF',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _toggleIncognitoMode,
                                child: Container(
                                  width: 40,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isIncognitoMode
                                        ? AppColors.purple
                                        : AppColors.divider,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const EyeIcon(
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Likes
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF5B21B6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              '44 человека тебя лайкнули',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 8,
                          ),
                        ],
                      ),
                    ),

                    // Chat list
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: MockData.chats.length,
                        itemBuilder: (context, index) {
                          return _ChatListItem(
                            chat: MockData.chats[index],
                            avatarIndex: index,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) => ChatDetailScreen(
                                  chat: MockData.chats[index],
                                  avatarIndex: index,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // Bottom nav inside panel
                    _buildBottomNav(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItemSvg(
              icon: GridIcon(size: 24, color: AppColors.purple),
              isActive: false,
              onTap: () {},
            ),
            _NavItemSvg(
              icon: ChatIcon(size: 20, color: Colors.black),
              isActive: true,
              onTap: () {},
            ),
            _NavItemSvg(
              icon: HeartIcon(size: 24, color: AppColors.purple),
              isActive: false,
              onTap: () {},
            ),
            _NavItemSvg(
              icon: SettingsIcon(size: 24, color: AppColors.purple),
              isActive: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final Chat chat;
  final int avatarIndex;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.chat,
    required this.avatarIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.divider, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            UserAvatar(
              index: avatarIndex,
              radius: 28,
              fallbackInitial: chat.userAvatar,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        chat.timestamp,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (chat.hasUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItemSvg extends StatelessWidget {
  final Widget icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItemSvg({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF2C94C),
            borderRadius: BorderRadius.circular(24),
          ),
          child: icon,
        ),
      );
    }

    return IconButton(icon: icon, onPressed: onTap);
  }
}
