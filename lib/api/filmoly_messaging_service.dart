import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:filmoly/api/firebase_web_config.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color, debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Servicio centralizado de notificaciones push (Android / iOS / Web),
/// basado en la implementación de Fitcron.
class FilmolyMessagingService {
  FirebaseMessaging? _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      // Inicializar Firebase (web con opciones explícitas, nativo con config por defecto)
      if (kIsWeb) {
        if (FilmolyFirebaseWebConfig.webFirebaseOptions.apiKey.isEmpty ||
            FilmolyFirebaseWebConfig.webFirebaseOptions.appId.isEmpty ||
            FilmolyFirebaseWebConfig.webFirebaseOptions.messagingSenderId.isEmpty ||
            FilmolyFirebaseWebConfig.webFirebaseOptions.projectId.isEmpty) {
          debugPrint(
            'FCM Web no configurado: rellena FilmolyFirebaseWebConfig.webFirebaseOptions/webVapidKey',
          );
          return;
        }
        await Firebase.initializeApp(
          options: FilmolyFirebaseWebConfig.webFirebaseOptions,
        );
      } else {
        await Firebase.initializeApp();
      }

      _firebaseMessaging = FirebaseMessaging.instance;

      // Notificaciones locales solo en Android/iOS/macOS
      if (!kIsWeb) {
        const androidInit = AndroidInitializationSettings('ic_notification');
        const iosInit = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
        const initSettings = InitializationSettings(
          android: androidInit,
          iOS: iosInit,
        );

        await _flutterLocalNotificationsPlugin.initialize(
          initSettings,
          onDidReceiveNotificationResponse: (NotificationResponse response) {
            debugPrint('Notificación tocada: ${response.payload}');
          },
        );
      }

      // Pedir permisos
      await _firebaseMessaging?.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Mensajes en primer plano (solo nativo)
      if (!kIsWeb) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          debugPrint('Mensaje FCM en primer plano: ${message.messageId}');

          final title = message.notification?.title ?? 'Filmoly';
          final body = message.notification?.body ?? 'Nueva notificación';

          await _showNotification(
            title: title,
            body: body,
            payload: message.data.toString(),
          );
        });
      }

      // Segundo plano
      FirebaseMessaging.onBackgroundMessage(
        _filmolyFirebaseMessagingBackgroundHandler,
      );

      // App abierta desde notificación
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App abierta desde notificación: ${message.messageId}');
      });

      // Si el token cambia, volver a registrarlo en backend
      _firebaseMessaging?.onTokenRefresh.listen((_) async {
        try {
          await syncPushConfig();
        } catch (_) {
          // ignorar
        }
      });
    } catch (e) {
      debugPrint('Error inicializando FilmolyMessagingService: $e');
    }
  }

  Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (kIsWeb) return; // Web usa el service worker

    const androidDetails = AndroidNotificationDetails(
      'filmoly_channel',
      'Filmoly Notifications',
      channelDescription: 'Canal de notificaciones de Filmoly',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: 'ic_notification',
      color: Color(0xFFB8D936), // Verde Filmoly
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _filmolyFirebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  try {
    await Firebase.initializeApp();
    debugPrint('Mensaje FCM en segundo plano: ${message.messageId}');
  } catch (e) {
    debugPrint('Error en background handler FCM Filmoly: $e');
  }
}

