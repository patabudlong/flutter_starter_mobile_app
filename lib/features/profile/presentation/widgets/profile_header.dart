import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;
  final int maxNameLength = 20;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  String _formatName(String? name) {
    if (name == null || name.isEmpty) return 'User';
    if (name.length <= maxNameLength) return name;
    return '${name.substring(0, maxNameLength)}...';
  }

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
          _formatName(user?.firstName),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          user?.email ?? '',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 