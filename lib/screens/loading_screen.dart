import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_starter_mobile_app/services/auth_service.dart';
import 'package:flutter_starter_mobile_app/screens/home_screen.dart';
import 'package:flutter_starter_mobile_app/screens/main_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthAndRedirect();
  }

  Future<void> checkAuthAndRedirect() async {
    final authService = AuthService(); // Or get it from your dependency injection
    final isValid = await authService.validateToken();
    
    if (!isValid) {
      // Token is invalid or doesn't exist, navigate to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Token is valid, navigate to main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()), // Replace with your main screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
} 