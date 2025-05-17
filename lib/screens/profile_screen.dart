import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeUtils.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeUtils.inputBackgroundColor,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.person,
                    color: ThemeUtils.textColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${dotenv.env['APP_NAME'] ?? 'Your App'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.mail_outline, color: Colors.white),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 16,
          ),
          child: Center(
            child: Text(
              'Profile Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 