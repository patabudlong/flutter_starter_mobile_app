import 'dart:convert';
import 'dart:math' as math;
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
    print('Saving access token: ${accessToken.substring(0, math.min(10, accessToken.length))}...');
    await _storage.write(key: _tokenKey, value: accessToken);
    if (refreshToken != null) {
      print('Saving refresh token: ${refreshToken.substring(0, math.min(10, refreshToken.length))}...');
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
    
    // Verify tokens were saved
    final savedToken = await _storage.read(key: _tokenKey);
    print('Verified saved token exists: ${savedToken != null}');
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
    print('Getting access token from storage');
    print('Token exists: ${token != null}');
    if (token != null) {
      print('Token first 10 chars: ${token.substring(0, math.min(10, token.length))}...');
    } else {
      print('No token found in storage');
    }
    return token;
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    print('Has token check: ${token != null && token.isNotEmpty}');
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
} 