import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ThemeUtils {
  static Color getColorFromHex(String hexColor, {String fallback = '#000000'}) {
    final color = hexColor.replaceAll('#', '');
    try {
      return Color(int.parse('FF$color', radix: 16));
    } catch (e) {
      return Color(int.parse('FF${fallback.replaceAll('#', '')}', radix: 16));
    }
  }

  static Color get primaryColor => getColorFromHex(
        dotenv.get('THEME_PRIMARY', fallback: '#00BCD4'),
      );

  static Color get secondaryColor => getColorFromHex(
        dotenv.get('THEME_SECONDARY', fallback: '#1565C0'),
      );

  static Color get accentColor => getColorFromHex(
        dotenv.get('THEME_ACCENT', fallback: '#FF8C00'),
      );

  static Color get dangerColor => getColorFromHex(
        dotenv.get('THEME_DANGER', fallback: '#F44336'),
      );

  static Color get warningColor => getColorFromHex(
        dotenv.get('THEME_WARNING', fallback: '#FFB300'),
      );

  static LinearGradient get backgroundGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          primaryColor,
          secondaryColor,
        ],
      );
      
  static Color get textColor => Colors.white;
  
  static Color get textColorSecondary => Colors.white.withOpacity(0.7);
  
  static Color get inputBackgroundColor => Colors.white.withOpacity(0.1);
  
  static BorderRadius get borderRadius => BorderRadius.circular(16);
  
  static EdgeInsets get defaultPadding => const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 16,
  );
} 