import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends ChangeNotifier {
  static final _notifications = FlutterLocalNotificationsPlugin();
static Future _notificationDetails()async
{

  
}
  /*static Future showNotification(
      {int id = 0, String title, String body,String payload}) async {
    _notifications.show(id, title, body,
    await _notificationDetails()
    , payload);
  }*/
}
