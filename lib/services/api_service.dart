import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_starter_mobile_app/models/user.dart';
import 'dart:convert';
import 'package:flutter_starter_mobile_app/services/token_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  final TokenService _tokenService = TokenService();
  final String baseUrl = dotenv.get('API_URL', fallback: 'http://localhost:8000');

  ApiService._internal();

  Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => http.Response('Timeout', 408),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    try {
      final token = await _tokenService.getAccessToken();
      
      if (token == null) {
        return {
          'success': false,
          'message': 'No access token found',
        };
      }

      final response = await http.get(
        Uri.parse('$baseUrl/auth/users/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('Timeout', 408),
      );

      print('Get user details response status: ${response.statusCode}');
      print('Get user details response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final user = User.fromJson(responseData);
        
        // Update stored user data with full details
        await _tokenService.saveUserData({
          'id': user.id,
          'name': user.fullName,
          'email': user.email,
          'username': user.username,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'middleName': user.middleName,
          'extensionName': user.extensionName,
          'createdAt': user.createdAt.toIso8601String(),
          'updatedAt': user.updatedAt.toIso8601String(),
        });

        return {
          'success': true,
          'data': user.toJson(),
        };
      }

      return {
        'success': false,
        'message': 'Failed to get user details',
        'statusCode': response.statusCode,
      };

    } catch (e) {
      print('Get user details error: $e');
      return {
        'success': false,
        'message': 'Connection error',
      };
    }
  }
} 