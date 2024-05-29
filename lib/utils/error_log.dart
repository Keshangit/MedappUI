import 'package:flutter/material.dart';
import 'package:med_assist/utils/exceptions/network_exceptions.dart';

class ErrorLog {
  static show(Object e) {
    debugPrint(e.toString());
    final error =
        NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(e));
    debugPrint("--------------------ERROR--------------------");
    // debugPrint(e.toString());
    debugPrint(error);
    debugPrint("--------------------ERROR--------------------");
    // if (NetworkExceptions.getErrorMessage(
    //             NetworkExceptions.getDioException(e)) ==
    //         "Unauthorized request" &&
    //     ctx != null) {
    //   Navigator.pushAndRemoveUntil(
    //       ctx,
    //       MaterialPageRoute(builder: (_) => const SignInPage()),
    //       (route) => false);
    // }
  }
}
