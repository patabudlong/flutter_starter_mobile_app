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
    final token = await _storage.read(key: _tokenKey);
    print('Retrieved token: ${token?.substring(0, 10)}...'); // Debug log - only show first 10 chars
    return token;
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    print('Has token check result: ${token != null}'); // Debug log
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
} 