import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/services/token_service.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/widgets/profile_details.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/widgets/profile_menu.dart';

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
                    ProfileHeader(user: _user),
                    const SizedBox(height: 24),
                    ProfileDetails(user: _user),
                    const SizedBox(height: 24),
                    ProfileMenu(user: _user),
                  ],
                ),
              ),
      ),
    );
  }
} 