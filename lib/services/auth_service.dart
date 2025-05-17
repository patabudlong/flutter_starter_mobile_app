import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String baseUrl = dotenv.get('BASE_URL');
  final TokenService _tokenService = TokenService();

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
        final responseData = json.decode(response.body);
        
        // Store tokens and user data
        await _tokenService.saveTokens(
          accessToken: responseData['access_token'], // adjust key based on your API response
          refreshToken: responseData['refresh_token'], // adjust key based on your API response
        );
        
        // If you have user data in the response, store it
        if (responseData['user'] != null) {
          await _tokenService.saveUserData(responseData['user']);
        }

        return {
          'success': true,
          'data': responseData,
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

  Future<void> logout() async {
    await _tokenService.clearAll();
  }

  Future<bool> isAuthenticated() async {
    return await _tokenService.hasToken();
  }
} 