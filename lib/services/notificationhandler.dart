import 'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    debugPrint("Arka planda gelen data:" + message["data"].toString());
    NotificationHandler.showNotification(message);
  }

  return Future<void>.value();
}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();

  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();
  BuildContext myContext;

  initializeFCMNotification(BuildContext context) async {
    myContext = context;

    var initializationSettingsAndroid = AndroidInitializationSettings(
        'sorisa'); //appicon ekle local bildiimg sotermek dkka 10
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    /*_fcm.subscribeToTopic("spor");
    String token = await _fcm.getToken();
    print("token :" + token);
    */

    //  var tok = await _fcm.getToken();
    //await FirebaseFirestore.instance.doc("tokens/x").set({"token": tok});
    // StreamSubscription stream =
    //_fcm.onTokenRefresh.listen((newToken) async {
    // await FirebaseFirestore.instance.doc("tokens/x").set({"token": newToken});
    // });
    print("stream grdş cıktı");
    // await stream.cancel();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //print("onMessage tetiklendi: $message");
        showNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        //print("onLaunch tetiklendi: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume tetiklendi: $message");
      },
    );
  }

  static void showNotification(Map<String, dynamic> message) async {
    debugPrint("ilk");
    var mesaj = Person(
      //   name: message["data"]["title"],
      name: "ddd",
      key: '1',
      //icon: userURLPath,
      //   iconSource: IconSource.FilePath
    );
    debugPrint("2");
    var mesajStyle = MessagingStyleInformation(mesaj,
        messages: [Message(message["data"]["message"], DateTime.now(), mesaj)]);

    debugPrint("3");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'dexterous.com.flutter.local_notifications',
        'Yeni Mesaj',
        'your channel description',
        //  style: AndroidNotificationStyle.Messaging,
        // styleInformation: mesajStyle,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    debugPrint("4");
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    debugPrint("5");
    await flutterLocalNotificationsPlugin.show(0, message["data"]["title"],
        message["data"]["message"], platformChannelSpecifics,
        payload: jsonEncode(message)); //jsonEncode(message));
    debugPrint("6");
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      // debugPrint('notification payload: ' + payload);

      Map<String, dynamic> gelenBildirim = await jsonDecode(payload);

      /*Navigator.of(myContext, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => LoginIslemleri()),
      );*/
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}
}
