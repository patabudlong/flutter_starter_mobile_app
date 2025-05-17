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
  bool _showError = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkApiHealth();
  }

  Future<void> _checkApiHealth() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    // Start a timer for 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_showError && _isLoading) {
        setState(() {
          _showError = true;
          _isLoading = false;
        });
      }
    });

    final apiService = ApiService();
    final isHealthy = await apiService.checkHealth();

    if (!mounted) return;

    if (isHealthy) {
      // Check if user is authenticated
      final isAuthenticated = await _authService.isAuthenticated();
      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(), // Change HomeScreen to MainScreen
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
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
      setState(() {
        _showError = true;
        _isLoading = false;
      });
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
        body: RefreshIndicator(
          color: ThemeUtils.accentColor,
          backgroundColor: ThemeUtils.textColor,
          onRefresh: _checkApiHealth,
          child: Stack(
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
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
                                      color: ThemeUtils.warningColor,
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
                                        dotenv.get('SUPPORT_PHONE', fallback: '[Your Support Phone Number]'),
                                        style: TextStyle(
                                          color: ThemeUtils.textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color: ThemeUtils.textColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            dotenv.get('SUPPORT_EMAIL', fallback: 'support@example.com'),
                                            style: TextStyle(
                                              color: ThemeUtils.textColor,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
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
                ],
              ),
              if (_showError)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          ThemeUtils.secondaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up,
                          color: ThemeUtils.textColor,
                          size: 36,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pull to refresh',
                          style: TextStyle(
                            color: ThemeUtils.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 