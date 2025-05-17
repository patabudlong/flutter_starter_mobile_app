import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/widgets/base_layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Profile',
      showCustomHeader: true,
      showProfilePicture: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Handle edit profile
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle edit profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Privacy Settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle privacy settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle notifications
              },
            ),
          ],
        ),
      ),
    );
  }
} 