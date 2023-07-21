import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oceanix/services/getstorage_services.dart';

class NotificationServices extends GetxService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token;

  @override
  Future<void> onInit() async {
    await notificationSetup();
    await onBackgroundMessage();
    await onForegroundMessage();
    super.onInit();
  }

  Future<void> notificationSetup() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: 'basic_channel_muted',
          channelName: 'Basic muted notifications ',
          channelDescription: 'Notification channel for muted basic tests',
          importance: NotificationImportance.High,
          playSound: false,
        )
      ],
    );
  }

  Future<void> onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');

          // if (Get.find<StorageService>().storage.read("notificationSound") ==
          //     true) {
          //   AwesomeNotifications().createNotification(
          //     content: NotificationContent(
          //       id: Random().nextInt(9999),
          //       channelKey: 'basic_channel',
          //       title: '${message.notification!.title}',
          //       body: '${message.notification!.body}',
          //       notificationLayout: NotificationLayout.BigText,
          //     ),
          //   );
          // } else {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: Random().nextInt(9999),
              channelKey: 'basic_channel_muted',
              title: '${message.notification!.title}',
              body: '${message.notification!.body}',
              notificationLayout: NotificationLayout.BigText,
            ),
          );

          // }

          // call_unseen_messages();
        }
      },
    );
  }

  Future<void> checkNotificationPermission() async {
    await messaging.requestPermission();
    // if (Get.find<StorageService>().storage.read('token') == "") {
    //   await getToken();
    // }
  }

  sendNotification(
      {required String userToken,
      required String message,
      required String title,
      required String subtitle}) async {
    print(userToken);
    var body = jsonEncode({
      "to": "$userToken",
      "notification": {
        "body": message,
        "title": title,
        "subtitle": subtitle,
      }
    });
    var pushNotif =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              "Authorization":
                  "key=AAAAmUh0AMo:APA91bFeqOEEOo8l_WJQxSQ_sa80Ikvolf0PRZ6fB4djaP5W3R7NT6dL0KDJhZYRx1Hesc5hSe8AlqBY3OnuzHh7QkapwRWJAcEFgmTjbDkMHzFoxVVytTaBAAGQl4ZSm_0UW2tBZeQu",
              "Content-Type": "application/json"
            },
            body: body);
    print("push notif: ${pushNotif.body}");
  }

  Future<void> getToken() async {
    token = await messaging.getToken();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read("id"))
        .update({"fcmToken": token});
  }
}

Future<void> onBackgroundMessage() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');

    // if (Get.find<StorageService>().storage.read("notificationSound") ==
    //     true) {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: Random().nextInt(9999),
    //       channelKey: 'basic_channel',
    //       title: '${message.notification!.title}',
    //       body: '${message.notification!.body}',
    //       notificationLayout: NotificationLayout.BigText,
    //     ),
    //   );
    // } else {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(9999),
        channelKey: 'basic_channel_muted',
        title: '${message.notification!.title}',
        body: '${message.notification!.body}',
        notificationLayout: NotificationLayout.BigText,
      ),
    );

    // }

    // call_unseen_messages();
  }
}
