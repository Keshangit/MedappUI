import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/ui/mp/home_page/admin_request_list.dart';
import 'package:med_assist/ui/mp/home_page/contact_us_screen.dart';
import 'package:med_assist/ui/mp/home_page/user_form.dart';
import 'package:med_assist/ui/mp/notification/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message");

  // NotificationService.showNotification(
  //   title: title!,
  //   body: body!,
  //   payload: message.data["payload"],
  //   actionButtons: [
  //     NotificationActionButton(
  //         key: 'check',
  //         label: 'check it out',
  //         actionType: ActionType.SilentAction)
  //   ],
  // );
}

class HomePage extends StatefulWidget {
  final String role;

  const HomePage({
    super.key,
    required this.role,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String notificationbody = "";

  // late RefreshController _refreshController;
  int currentDifference = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationService.initializeNotification();

    // _refreshController = RefreshController(initialRefresh: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getOrders();
    // });

    printToken();
    // _getRole();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        String? title = message.notification!.title;
        String? body = message.notification!.body;

        log("--------On message notifiaction----------");
        // log(json.encode(message.toMap()));

        NotificationService.showNotification(
          title: title!,
          body: body!,
          payload: message.data["payload"],
          actionButtons: [
            NotificationActionButton(
                key: 'check',
                label: 'check it out',
                actionType: ActionType.SilentAction)
          ],
        );
      },
    );
  }

  void printToken() async {
    if (widget.role == "admin") {
      SubscribeAdmin();
    } else {
      SubscribeUser();
    }
    // _firebaseMessaging.subscribeToTopic("user");
    final fCMTToken = await _firebaseMessaging.getToken();
    log('Token: $fCMTToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Home",
          showLeadingIcon: false,
        ),
        body: widget.role == "admin"
            ? const RequestList()
            : widget.role == "seafarer"
                ? const UserForm()
                : const ContactUsScreen());
  }

  void SubscribeUser() async {
    await FirebaseMessaging.instance
        .subscribeToTopic("user")
        .then((value) => print("User Subs"));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: "notification_app",
            title: message.notification!.title,
            body: message.notification!.body),
      );
    });
  }

  void SubscribeAdmin() async {
    await FirebaseMessaging.instance
        .subscribeToTopic("admin")
        .then((value) => print("User admin"));
    await FirebaseMessaging.instance.unsubscribeFromTopic("user");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: "notification_app",
            title: message.notification!.title,
            body: message.notification!.body),
      );
    });
  }
}
