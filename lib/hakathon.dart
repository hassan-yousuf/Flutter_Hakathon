import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hakathon/main.dart';

class PushNotificationExample extends StatefulWidget {
  const PushNotificationExample({Key? key}) : super(key: key);

  @override
  State<PushNotificationExample> createState() =>
      _PushNotificationExampleState();
}

class _PushNotificationExampleState extends State<PushNotificationExample> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      controllers.value.text,
      controller.value.text,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controllers,
              decoration: InputDecoration(
                labelText: 'Type message title!',
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Type message body!',
              ),
            ),
            FlatButton(
              color: Colors.orange,
              onPressed: () {
                showNotification();
                controller.clear();
                controllers.clear();
              },
              child: Text(' Send Message '),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController controllers = TextEditingController();
  TextEditingController controller = TextEditingController();
}
