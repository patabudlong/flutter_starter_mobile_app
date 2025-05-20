import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter_starter_mobile_app/services/auth_service.dart';
import 'package:flutter_starter_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_starter_mobile_app/services/token_service.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';
import 'package:flutter_starter_mobile_app/widgets/discard_changes_modal.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final _apiService = ApiService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final tokenService = TokenService();
    final userData = await tokenService.getUserData();
    
    if (userData != null && userData['id'] != null) {
      final response = await _apiService.getUserDetails(userData['id']);
      if (response['success'] && mounted) {
        setState(() {
          _user = User.fromJson(response['data']);
          _isLoading = false;
        });
      }
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => DiscardChangesModal(
        title: 'Logout',
        message: 'Are you sure you want to logout?',
        confirmText: 'Logout',
        cancelText: 'Cancel',
        confirmColor: Colors.red.withOpacity(0.8),
        onConfirm: () async {
          final authService = AuthService();
          await authService.logout();
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeUtils.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: 'Settings',
          showProfile: true,
          showNotification: true,
          showScanner: true,
          userName: _user?.fullName,
          userEmail: _user?.email,
          userId: _user?.id,
          firstName: _user?.firstName,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Account'),
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Profile Settings',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                title: 'Privacy',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.security,
                title: 'Security',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              _buildSectionTitle('Preferences'),
              _buildMenuItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Dark',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              _buildSectionTitle('Support'),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              _buildMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                textColor: ThemeUtils.dangerColor,
                onTap: _handleLogout,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: textColor ?? Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
          ),
        ),
        subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            )
          : null,
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
} 