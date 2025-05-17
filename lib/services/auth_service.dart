import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String baseUrl = dotenv.get('BASE_URL');

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Attempting login to: $baseUrl/auth/login'); // Debug log
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': email,
          'password': password,
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('Timeout', 408),
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      }

      if (response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Invalid request format',
        };
      }

      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Invalid credentials',
        };
      }

      return {
        'success': false,
        'message': 'Server error occurred',
      };
    } catch (e) {
      print('Login error: $e'); // Debug log
      return {
        'success': false,
        'message': 'Connection error',
      };
    }
  }
} 