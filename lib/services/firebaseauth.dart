import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessanging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessanging.requestPermission();
    final fcmToken = await _firebaseMessanging.getToken();

    print("token: $fcmToken");
  }
}
