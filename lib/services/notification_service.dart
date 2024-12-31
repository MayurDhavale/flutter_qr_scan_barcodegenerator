import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_scan_generate_flutter_app/mainscreen.dart';
import 'package:qr_scan_generate_flutter_app/notification_screen.dart';

class NotificationService {
  FirebaseMessaging messigning = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//for notification request
  void requestNotificationPermission() async {
    NotificationSettings settings = await messigning.requestPermission(
      alert: true,
      announcement: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      badge: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user provisional granted permission');
    } else {
      // Get.Snackbar(
      //   'Notification permission denied',
      //   'Please allow notification to receive updates.',
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<String> getDeviceToken() async {
    NotificationSettings settings = await messigning.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await messigning.getToken();
    print("Token -> $token");
    return token!;
  }

//init
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitSetting =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosInitSetting = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  //firebase init

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification!;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notification title: ${notification.title}");
        print("notification body ${notification.body}");
      }

      //for IOS
      if (Platform.isIOS) {
        iosForegroundMessage();
      }

      //For Android
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        //handleMessage(context, message);
        showNotification(message);
      }
    });
  }

//function to show notifications

  Future<void> showNotification(RemoteMessage message) async {
    //channel setting
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      showBadge: true,
      playSound: true,
      importance: Importance.high,
    );

    //android setting

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      sound: channel.sound,
      playSound: true,
    );

    //ios setting
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    //setting merge
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    //show notification
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: 'my data .... ');
    });
  }

//Background and terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });

    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null && message.data.isNotEmpty) {
          handleMessage(context, message);
        }
      },
    );
  }

//handle message

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotificationScreen(message:message)));
  }

//IOS Message
  Future iosForegroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
