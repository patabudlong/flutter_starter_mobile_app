import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/widgets/base_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Home',
      showCustomHeader: true,
      showProfilePicture: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Handle settings
          },
        ),
      ],
      child: const Center(
        child: Text('Welcome to Your App!'),
      ),
    );
  }
} 