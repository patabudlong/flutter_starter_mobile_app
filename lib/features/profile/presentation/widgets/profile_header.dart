import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
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
          user?.fullName ?? 'User',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user?.email ?? '',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
} 