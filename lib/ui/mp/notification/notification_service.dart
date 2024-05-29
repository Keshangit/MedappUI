import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/ui/mp/home_page/home_page.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [
        NotificationChannel(
          channelGroupKey: "notification_app",
          channelKey: "notification_app",
          channelName: "notification_app",
          channelDescription: "Channel of notification_app",
          defaultColor: Colors.red,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          enableVibration: true,
          enableLights: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "notification_app_group",
          channelGroupName: "Group_01",
        )
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onDismissActionReceivedMethod");
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onActionReceivedMethod");
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == true.toString()) {
      MaterialPageRoute(
          builder: (_) => const HomePage(
                role: "admin",
              ));
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigpicture,
    final List<NotificationActionButton>? actionButtons,
    final bool sheduled = false,
    final int? interval,
  }) async {
    assert(!sheduled || (sheduled && interval == null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "notification_app",
        color: Colors.green,
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        largeIcon: "resource://drawable/notification_icon2",
        bigPicture: bigpicture,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.black,
      ),
      actionButtons: actionButtons,
      schedule: sheduled
          ? NotificationInterval(
              interval: interval,
              timeZone: AwesomeNotifications.localTimeZoneIdentifier,
              preciseAlarm: true,
            )
          : null,
    );
  }
}
