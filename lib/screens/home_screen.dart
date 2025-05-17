import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/widgets/base_layout.dart';
import 'package:flutter_starter_mobile_app/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Home',
      showCustomHeader: true,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set to home tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
          // Add other navigation cases later
        },
      ),
      child: const Center(
        child: Text('Welcome to Your App!'),
      ),
    );
  }
} 