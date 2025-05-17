import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/widgets/base_layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Home',
      showCustomHeader: true,
      showProfilePicture: true,
      actions: const [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: null,
        ),
      ],
      child: Center(
        child: Text('Welcome to ${dotenv.env['APP_NAME'] ?? 'Your App'}'),
      ),
    );
  }
} 