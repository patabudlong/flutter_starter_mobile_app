import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/screens/change_password_screen.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/screens/notifications_screen.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/screens/privacy_settings_screen.dart';

class ProfileMenu extends StatelessWidget {
  final User? user;

  const ProfileMenu({
    super.key,
    required this.user,
  });

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          Icons.edit,
          'Edit Profile',
          onTap: user != null ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(user: user!),
              ),
            );
          } : null,
        ),
        _buildMenuItem(
          Icons.lock_outline, 
          'Change Password',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            );
          },
        ),
        _buildMenuItem(
          Icons.notifications_outlined, 
          'Notifications',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
        _buildMenuItem(
          Icons.privacy_tip_outlined, 
          'Privacy Settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacySettingsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
} 