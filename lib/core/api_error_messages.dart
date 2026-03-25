import 'dart:convert';

import 'package:filmaniak/generated/l10n.dart';

/// Devuelve el mensaje de error localizado según el código del backend (auth).
/// Si el código no se reconoce, devuelve [S.current.errorAuthGeneric].
String getAuthErrorMessage(String? code) {
  if (code == null || code.isEmpty) return S.current.errorAuthGeneric;
  switch (code) {
    case 'invalid_username':
      return S.current.errorAuthInvalidUsername;
    case 'invalid_email':
      return S.current.errorAuthInvalidEmail;
    case 'invalid_password':
      return S.current.errorAuthInvalidPassword;
    case 'username_exists':
      return S.current.errorAuthUsernameExists;
    case 'email_exists':
      return S.current.errorAuthEmailExists;
    case 'register_failed':
      return S.current.errorAuthRegisterFailed;
    case 'session_failed':
      return S.current.errorAuthSessionFailed;
    case 'too_many_requests':
      return S.current.errorAuthTooManyRequests;
    case 'missing_fields':
      return S.current.errorAuthMissingFields;
    case 'invalid_credentials':
      return S.current.errorAuthInvalidCredentials;
    case 'missing_login':
      return S.current.errorAuthMissingLogin;
    case 'invalid_code':
      return S.current.errorAuthInvalidCode;
    case 'too_many_attempts':
      return S.current.errorAuthTooManyAttempts;
    case 'expired_code':
      return S.current.errorAuthExpiredCode;
    case 'wrong_password':
      return S.current.errorAuthWrongPassword;
    case 'missing_password':
      return S.current.errorAuthInvalidPassword;
    case 'delete_failed':
      return S.current.errorAuthDeleteAccountFailed;
    case 'missing_token':
      return S.current.errorApiSession;
    case 'network_error':
      return S.current.errorApiNetwork;
    default:
      return S.current.errorAuthGeneric;
  }
}

bool _isFilmaniakAuthErrorCode(String code) {
  const known = <String>{
    'invalid_username',
    'invalid_email',
    'invalid_password',
    'username_exists',
    'email_exists',
    'register_failed',
    'session_failed',
    'too_many_requests',
    'missing_fields',
    'invalid_credentials',
    'missing_login',
    'invalid_code',
    'too_many_attempts',
    'expired_code',
    'wrong_password',
    'missing_password',
    'delete_failed',
    'missing_token',
    'network_error',
  };
  return known.contains(code);
}

/// Respuesta JSON típica de WordPress REST: `{ code, message, data: { status } }`.
/// Convierte códigos técnicos y textos largos en mensajes cortos para el usuario.
String mapJsonErrorToUserMessage(int statusCode, Map<String, dynamic>? json) {
  final code = json?['code'] as String?;
  final rawMsg = (json?['message'] as String?) ?? '';

  if (code != null && code.isNotEmpty) {
    if (_isFilmaniakAuthErrorCode(code)) {
      return getAuthErrorMessage(code);
    }

    switch (code) {
      case 'rest_no_route':
      case 'rest_no_match':
      case 'rest_invalid_handler':
      case 'rest_unsupported_method':
        return S.current.errorApiEndpointUnavailable;
      case 'rest_forbidden':
      case 'rest_cannot_view':
      case 'rest_cannot_edit':
      case 'rest_cannot_create':
      case 'rest_cannot_delete':
        return S.current.errorApiForbidden;
      case 'rest_not_found':
        return S.current.errorApiNotFound;
      case 'rest_cookie_invalid_nonce':
      case 'rest_not_logged_in':
        return S.current.errorApiUnauthorized;
      default:
        if (code.startsWith('jwt_') ||
            code.contains('invalid_token') ||
            code.contains('expired_token')) {
          return S.current.errorApiUnauthorized;
        }
        break;
    }
  }

  final lower = rawMsg.toLowerCase();
  if (lower.contains('no route') ||
      lower.contains('ninguna ruta') ||
      lower.contains('coincida con la url') ||
      lower.contains('coincida con la url y el método') ||
      lower.contains('matching the url and request method')) {
    return S.current.errorApiEndpointUnavailable;
  }

  switch (statusCode) {
    case 401:
      return S.current.errorApiUnauthorized;
    case 403:
      return S.current.errorApiForbidden;
    case 404:
      return S.current.errorApiNotFound;
    case 400:
    case 405:
    case 409:
    case 422:
      return S.current.errorApiBadRequest;
    default:
      break;
  }

  if (statusCode >= 500) {
    return S.current.errorApiServer;
  }

  return S.current.errorApiGeneric;
}

Map<String, dynamic>? tryDecodeJsonObject(String body) {
  if (body.isEmpty) return null;
  try {
    final o = jsonDecode(body);
    if (o is Map<String, dynamic>) return o;
    if (o is Map) return Map<String, dynamic>.from(o);
  } catch (_) {}
  return null;
}

/// Para cualquier [http.Response]: intenta JSON y aplica [mapJsonErrorToUserMessage].
String userFacingMessageFromHttp(int statusCode, String body) {
  final json = tryDecodeJsonObject(body);
  return mapJsonErrorToUserMessage(statusCode, json);
}

/// Errores de red / timeout (excepciones al llamar a `http`).
String userFacingNetworkError(Object error) {
  return S.current.errorApiNetwork;
}
