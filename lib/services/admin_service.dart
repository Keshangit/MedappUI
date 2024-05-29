import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/models/unverified_user_model.dart';
import 'package:http/http.dart' as http;

class AdminService {
  static Future<List<UnverifiedUserModel>> getUnverifiedList(
      BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}users/get-unverified-users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData
            .map((e) => UnverifiedUserModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load unverified users');
      }
    } catch (e) {
      throw Exception('Failed to load unverified users: $e');
    }
  }

  static Future<Map<String, dynamic>> verifyAccount(
      BuildContext context, String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    // try {
    final response = await http.post(
      Uri.parse('${baseUrl}users/account-verify'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(body),
    );
    debugPrint(response.body.toString());
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 201) {
      debugPrint(response.statusCode.toString());

      return jsonDecode(response.body);
    } else {
      final errorResponse = jsonDecode(response.body);
      throw Exception(
          errorResponse['message'] ?? 'Failed to verify user account');
    }
    // }
    // catch (e) {
    //   throw Exception('Failed to verify user account: $e');
    // }
  }
}
