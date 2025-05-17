import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showProfile;
  final bool showNotification;
  final bool showScanner;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onScannerTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.showProfile = true,
    this.showNotification = true,
    this.showScanner = true,
    this.onProfileTap,
    this.onNotificationTap,
    this.onScannerTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      title: showProfile ? _buildProfileTitle() : _buildSimpleTitle(),
      actions: actions ?? _buildDefaultActions(),
    );
  }

  Widget _buildProfileTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                '${dotenv.env['APP_NAME'] ?? 'Your App'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleTitle() {
    return Text(
      title ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildDefaultActions() {
    final defaultActions = <Widget>[];

    if (showNotification) {
      defaultActions.add(
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.mail_outline, color: Colors.white),
              onPressed: onNotificationTap ?? () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (showScanner) {
      defaultActions.add(
        IconButton(
          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
          onPressed: onScannerTap ?? () {},
        ),
      );
    }

    return defaultActions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
} 