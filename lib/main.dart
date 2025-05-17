import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/screens/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: dotenv.get('APP_NAME', fallback: 'Your App'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeUtils.primaryColor,
          primary: ThemeUtils.primaryColor,
          secondary: ThemeUtils.secondaryColor,
          background: ThemeUtils.secondaryColor,
        ),
        scaffoldBackgroundColor: ThemeUtils.primaryColor,
      ),
      home: const LoadingScreen(),
    );
  }
}
