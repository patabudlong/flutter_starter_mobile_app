import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  final _storage = const FlutterSecureStorage();
  
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _tokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final userDataString = json.encode(userData);
    await _storage.write(key: _userDataKey, value: userDataString);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userDataString = await _storage.read(key: _userDataKey);
    if (userDataString != null) {
      return json.decode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null;
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
} 