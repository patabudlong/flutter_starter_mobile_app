import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/services/api_service.dart';
import 'package:flutter_starter_mobile_app/features/auth/presentation/screens/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _checkApiHealth();
  }

  Future<void> _checkApiHealth() async {
    // Start a timer for 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_showError) {
        setState(() => _showError = true);
      }
    });

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
      setState(() => _showError = true);
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
              if (_showError) ...[
                Icon(
                  Icons.error_outline,
                  color: ThemeUtils.textColor,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Text(
                        "We're having trouble connecting to our servers right now. Please check your internet connection and try again.\n\nIf the problem persists, please contact our Customer Support team for assistance.",
                        style: TextStyle(
                          color: ThemeUtils.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Support Contact:',
                        style: TextStyle(
                          color: ThemeUtils.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: ThemeUtils.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Call us at: ${dotenv.get('SUPPORT_PHONE', fallback: '+63 XXX XXX XXXX')}',
                            style: TextStyle(
                              color: ThemeUtils.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: ThemeUtils.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Email: ${dotenv.get('SUPPORT_EMAIL', fallback: 'support@example.com')}',
                            style: TextStyle(
                              color: ThemeUtils.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ] else
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