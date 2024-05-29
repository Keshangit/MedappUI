import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/dialogs/change_password_dialog.dart';
import 'package:med_assist/dialogs/custome_loading_dialog.dart';
import 'package:med_assist/dialogs/regitration_complete_dialog.dart';
import 'package:med_assist/services/secure_storage_service.dart';
import 'package:med_assist/shared_widgets/snak_bars.dart';
import 'package:med_assist/ui/landing/sign_in/sign_in.dart';
import 'package:med_assist/ui/mp/navigation.dart';
import 'package:med_assist/ui/mp/otp/submit_otp_screen.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends ChangeNotifier {
  String userId = '';
  String otpCode = '';
  String mobileNumber = '';
  String consumerId = '';
  String role = '';

  void checkLogin(BuildContext context) {
    print("checkLogin");
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        String? token = await SecureStorageManager().getToken();
        print(token);
        if (token != null) {
          print(consumerId);
          applicationInit(context);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
            (route) => false,
          );
        }
      },
    );
    ;
  }

  Future<void> applicationInit(BuildContext context) async {
    try {
      authToken = await SecureStorageManager().getToken() ?? '';
      role = await SecureStorageManager().getRole() ?? '';
      print(role);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Navigation(
            role: role,
          ),
        ),
        (route) => false,
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(
          error.toString(),
        ),
      );
    }
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Logging In',
        ),
      );

      final response = await http.post(
        Uri.parse('${baseUrl}users/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      Navigator.pop(context);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        SecureStorageManager().storeToken(
          responseData['token'].toString(),
        );
        SecureStorageManager().storeRole(
          responseData['role'].toString(),
        );

        print(responseData['role'].toString());
        // String role = responseData['role'];
        applicationInit(context);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Invalid credentials!'),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> foreignRegister(
    BuildContext context,
    String name,
    String dob,
    String idMbsPass,
    String country,
    String email,
    String password,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "dob": dob,
      "idMbsPass": idMbsPass,
      "role": "foreigner",
      "country": country,
      "email": email,
      "password": password,
    };

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Registering',
        ),
      );
      //print(body.toString());
      final response = await http.post(
        Uri.parse('${baseUrl}users/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      Navigator.pop(context);
      // print(response.toString());
      if (response.statusCode == 201) {
        sendAndroidNotification();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
        showDialog(
          context: context,
          builder: (context) => const RegistrationCompleteDialog(),
        );
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(
              'Could not complete registration, please try again later.'),
        );
        // print('Error: ${response.statusCode}, ${response.reasonPhrase}');
        // print('Response Body: ${await response.body}');
      }
    } catch (e) {
      // print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> localRegister(
    BuildContext context,
    String name,
    String dob,
    String idMbsPass,
    String email,
    String password,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "dob": dob,
      "idMbsPass": idMbsPass,
      "role": "seafarer",
      "email": email,
      "password": password,
    };

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Registering',
        ),
      );
      //print(body.toString());
      final response = await http.post(
        Uri.parse('${baseUrl}users/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      Navigator.pop(context);
      print(response.body);
      if (response.statusCode == 201) {
        sendAndroidNotification();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
        showDialog(
          context: context,
          builder: (context) => const RegistrationCompleteDialog(),
        );
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Could not complete registration, please try again.'),
        );
        // print('Error: ${response.statusCode}, ${response.reasonPhrase}');
        // print('Response Body: ${await response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> sendAndroidNotification() async {
    print("SEND NOTIFICATION");
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAPmOgU5g:APA91bEqc5X12r3zv0AtozWvHvcXs5C1NS7BRm2PvnwyuFRUCYOyht3Qy6R2kLDFObVq3jyDToJ--MKpApQySfkq9xeN_eUtbDDkCEUGAxj6k4gXosUxeloVFgJMFvCZ5MOPcZQLSghF',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "Med Assist Notification",
              'title': 'New User Registered',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': '/topics/admin',
            // 'token': authorizedSupplierTokenId
          },
        ),
      );
      if (response.statusCode == 200) {
        print('FCM notification sent successfully: ${response.body}');
      } else {
        print(
            'Failed to send FCM notification. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      response;
    } catch (e) {
      print('Error sending FCM notification: $e');
    }
  }

  Future<void> sendOtp(
    BuildContext context,
    String email,
  ) async {
    //  print(email);
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Verify...',
        ),
      );
      final response = await http.get(
        Uri.parse('${baseUrl}users/get-forgot-pw-otp/$email'),
      );
      // print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      // print('Response Body: ${await response.body}');
      Navigator.pop(context);
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          successSnackBar('Sent OTP your Email'),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubmitOTPScreen(
              email: email,
            ),
          ),
        );
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Something Went Wrong'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> updatePassword(BuildContext context, String email,
      String newPassword, String otp) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": newPassword,
      "passwordConfirm": newPassword,
      "otpCode": otp
    };
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Updating Password',
        ),
      );
      final response = await http.post(
        Uri.parse('${baseUrl}users/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      Navigator.pop(context);
      // print(response.reasonPhrase);
      if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const SignInScreen(),
        //   ),
        //       (route) => false,
        // );
        showDialog(
          context: context,
          builder: (context) => const ChangePasswordDialog(),
        );
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Could not update password, please try again later.'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }
  // Future<void> resentForgotPassword(
  //     BuildContext context,
  //     String email,
  //     ) async {
  //   Map<String, dynamic> body = {
  //     'email': email,
  //   };
  //   try {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => const CustomLoadingDialog(
  //         title: 'Searching Account',
  //       ),
  //     );
  //     String? token = await SecureStorageManager().getToken();
  //     final response = await http.post(
  //       Uri.parse('${baseUrl}auth/email/verification/otp/initiate'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'x-auth-token': token.toString(),
  //       },
  //       body: jsonEncode(body),
  //     );
  //     Navigator.pop(context);
  //     if (response.statusCode == 201) {
  //       //final responseData = json.decode(response.body);
  //       notifyListeners();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         errorSnackBar('Could not find an account, please try again later.'),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       errorSnackBar(e.toString()),
  //     );
  //   }
  // }
  //
  //
  //
  // Future<void> sendOtp(
  //     BuildContext context,
  //     String newEmail,
  //     String password,
  //     ) async {
  //   //print(email);
  //   Map<String, dynamic> body = {
  //     'newEmail': newEmail,
  //     'currentPassword': password,
  //   };
  //   try {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => const CustomLoadingDialog(
  //         title: 'Verify...',
  //       ),
  //     );
  //     print(consumerId);
  //     String? token = await SecureStorageManager().getToken();
  //     final response = await http.post(
  //       Uri.parse('${baseUrl}user-accounts/consumers/change-email/initiate/${Provider.of<UserService>(context, listen: false).consumerID}'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'x-auth-token': token.toString(),
  //       },
  //       body: jsonEncode(body),
  //     );
  //     print('Error: ${response.statusCode}, ${response.reasonPhrase}');
  //     print('Response Body: ${await response.body}');
  //     Navigator.pop(context);
  //     print(response.body);
  //     if (response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         successSnackBar('Sent OTP your New Email'),
  //
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>  SubmitOTPScreen(
  //             newEmail: newEmail,
  //             password: password,
  //           ),
  //         ),
  //       );
  //       notifyListeners();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         errorSnackBar('Something Went Wrong'),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       errorSnackBar(e.toString()),
  //     );
  //   }
  // }
  //
}
