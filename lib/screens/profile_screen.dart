import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter_starter_mobile_app/services/token_service.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeUtils.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: 'Profile',
          showProfile: true,
          showNotification: true,
          showScanner: true,
          userName: _user?.fullName,
          userEmail: _user?.email,
          userId: _user?.id,
          firstName: _user?.firstName,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildProfileDetails(),
                    const SizedBox(height: 24),
                    _buildProfileMenu(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _user?.fullName ?? 'User',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _user?.email ?? '',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('First Name', _user?.firstName ?? ''),
          _buildDetailRow('Middle Name', _user?.middleName ?? ''),
          _buildDetailRow('Last Name', _user?.lastName ?? ''),
          _buildDetailRow('Extension', _user?.extensionName ?? ''),
          _buildDetailRow('Username', _user?.username ?? ''),
          _buildDetailRow('Member Since', _formatDate(_user?.createdAt)),
          _buildDetailRow('Last Updated', _formatDate(_user?.updatedAt)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildProfileMenu() {
    return Column(
      children: [
        _buildMenuItem(Icons.edit, 'Edit Profile'),
        _buildMenuItem(Icons.lock_outline, 'Change Password'),
        _buildMenuItem(Icons.notifications_outlined, 'Notifications'),
        _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Settings'),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
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
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }
} 