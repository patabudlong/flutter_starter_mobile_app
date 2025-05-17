import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkApiHealth();
  }

  Future<void> _checkApiHealth() async {
    final apiService = ApiService();
    final isHealthy = await apiService.checkHealth();

    if (!mounted) return;

    if (isHealthy) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text(
                  'Unable to connect to server',
                  style: TextStyle(color: ThemeUtils.textColor),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: ThemeUtils.textColor,
                  size: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
          backgroundColor: ThemeUtils.dangerColor,
          duration: const Duration(seconds: 4),
        ),
      );
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dotenv.get('APP_NAME', fallback: 'Your App'),
                style: TextStyle(
                  color: ThemeUtils.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              CircularProgressIndicator(
                color: ThemeUtils.textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 