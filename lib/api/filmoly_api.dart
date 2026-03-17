import 'dart:convert';

import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/core/secure_storage.dart';
import 'package:filmoly/model/user_model.dart';
import 'package:filmoly/model/app_status_model.dart';
import 'package:http/http.dart' as http;

/// Base URL del WordPress (La Retroteca).
const String filmolyBaseUrl = 'https://retroteca.org/wp-json/filmoly/v1';

final FilmolySecureStorage _secureStorage = FilmolySecureStorage();

class FilmolyApi {
  static const String _baseUrl = filmolyBaseUrl;

  static Map<String, String> _headers({String? token}) {
    final map = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      map['Authorization'] = 'Bearer $token';
    }
    return map;
  }

  /// POST /auth/register
  /// Devuelve el usuario y token en éxito; en error lanza o devuelve mapa con code/message.
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    final body = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
    if (displayName != null && displayName.isNotEmpty) {
      body['display_name'] = displayName;
    }
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(body),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    if (response.statusCode == 201 && (data['success'] == true)) {
      return data;
    }
    // Error: WP_Error style { code, message } o similar
    final message = data['message'] as String? ?? 'Error de registro';
    final code = data['code'] as String?;
    return {'success': false, 'message': message, 'code': code, 'data': data};
  }

  /// POST /auth/login
  static Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'login': login, 'password': password}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    if (response.statusCode == 200 && (data['success'] == true)) {
      return data;
    }
    final message = data['message'] as String? ?? 'Credenciales incorrectas';
    return {'success': false, 'message': message, 'data': data};
  }

  /// GET /auth/me — valida token y devuelve usuario o null.
  static Future<FilmolyUser?> validateToken(String token) async {
    final url = Uri.parse('$_baseUrl/auth/me');
    final response = await http.get(
      url,
      headers: _headers(token: token),
    );
    if (response.statusCode != 200) return null;
    final data = jsonDecode(response.body) as Map<String, dynamic>?;
    if (data == null || data['success'] != true) return null;
    final userJson = data['user'];
    if (userJson is! Map<String, dynamic>) return null;
    return FilmolyUser.fromJson(userJson);
  }

  /// POST /auth/logout
  static Future<bool> logout(String token) async {
    final url = Uri.parse('$_baseUrl/auth/logout');
    final response = await http.post(
      url,
      headers: _headers(token: token),
    );
    return response.statusCode == 200;
  }

  /// POST /auth/forgot-password
  static Future<Map<String, dynamic>> forgotPassword(String login) async {
    final url = Uri.parse('$_baseUrl/auth/forgot-password');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'login': login}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    final success = response.statusCode == 200 && (data['success'] == true);
    final message = data['message'] as String? ?? (success ? 'OK' : 'Error');
    return {'success': success, 'message': message};
  }

  /// POST /auth/reset-password
  static Future<Map<String, dynamic>> resetPassword({
    required String login,
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/reset-password');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({
        'login': login,
        'code': code,
        'new_password': newPassword,
      }),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    final success = response.statusCode == 200 && (data['success'] == true);
    final message = data['message'] as String? ?? (success ? 'OK' : 'Error');
    return {'success': success, 'message': message};
  }

  /// Guarda el token en secure storage (tras login o registro).
  static Future<void> saveToken(String token) async {
    await _secureStorage.setToken(token);
    globalUserToken = token;
  }

  /// Cierra sesión en servidor y borra token local.
  static Future<void> logoutAndClear() async {
    if (globalUserToken.isNotEmpty) {
      await logout(globalUserToken);
    }
    globalUserToken = '';
    globalCurrentUser = FilmolyUser();
    await _secureStorage.removeToken();
  }

  /// Verifica un token de reCAPTCHA v3 contra el endpoint de WordPress.
  static Future<Map<String, dynamic>> verifyRecaptcha(String token) async {
    final url = Uri.parse('$filmolyBaseUrl/verify-recaptcha');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'token': token}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    return data;
  }

  /// GET /status — devuelve versión mínima y estado (mantenimiento).
  static Future<FilmolyAppStatus?> getStatus() async {
    final url = Uri.parse('$filmolyBaseUrl/status');
    try {
      final response = await http.get(url, headers: _headers());
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return FilmolyAppStatus.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  /// POST /push/register-token — guarda/actualiza el token FCM del dispositivo.
  ///
  /// Backend esperado (WordPress): `wordpress_backend/notificaciones.php`
  static Future<bool> registerPushToken({
    required String token,
    required String fcmToken,
  }) async {
    final url = Uri.parse('$_baseUrl/push/register-token');
    try {
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({
          'fcm_token': fcmToken,
        }),
      );
      if (response.statusCode != 200) return false;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  /// POST /push/unregister-token — marca un token (o deviceId) como inactivo.
  static Future<bool> unregisterPushToken({
    required String token,
    required String fcmToken,
  }) async {
    final url = Uri.parse('$_baseUrl/push/unregister-token');
    try {
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({
          'fcm_token': fcmToken,
        }),
      );
      if (response.statusCode != 200) return false;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }
}
