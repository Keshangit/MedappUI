import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:med_assist/constants.dart';

class UserFormService {
  static Future<String> userFormSubmit(
    // static Future<Map<String, dynamic>> userFormSubmit(
    // BuildContext context,
    String firstName,
    String middleName,
    String lastName,
    String email,
    String mobile,
    String address,
    String dob,
    String gender,
    String mbasid,
    String memberType,
    String lastSignOffDate,
    String medicalProblem,
    String symptoms,
    String requiredService,
    String nameHospital,
    String addressHospital,
    String nameDoctor,
    String dateOfVisit,
    String likeAppointment,
    List<File> uploadedFiles,
  ) async {
    var uri = Uri.parse('${baseUrl}forms/form-submission');
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Authorization': 'Bearer $authToken',
    });

    // Add form fields
    request.fields['firstName'] = firstName;
    request.fields['middleName'] = middleName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['mobile'] = mobile;
    request.fields['address'] = address;
    request.fields['dob'] = dob;
    request.fields['gender'] = gender;
    request.fields['mbasid'] = mbasid;
    request.fields['memberType'] = memberType;
    request.fields['lastSignOffDate'] = lastSignOffDate;
    request.fields['medicalProblem'] = medicalProblem;
    request.fields['symptoms'] = symptoms;
    request.fields['requiredService'] = requiredService;
    request.fields['nameHospital'] = nameHospital;
    request.fields['addressHospital'] = addressHospital;
    request.fields['nameDoctor'] = nameDoctor;
    request.fields['dateOfVisit'] = dateOfVisit;
    request.fields['likeAppointment'] = likeAppointment;

    // var stream = http.ByteStream(uploadedFiles.first.openRead());
    // stream.cast();
    // var length = await uploadedFiles.first.length();
    // var multiport = http.MultipartFile(
    //   "file",
    //   stream,
    //   length,
    //   filename: uploadedFiles.first.path,
    // );
    // request.files.add(multiport);

    // Add files
    for (File file in uploadedFiles) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file', // Make sure this field name matches what the server expects
        stream,
        length,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return respStr;
      } else {
        debugPrint('Error response: $respStr');
        throw Exception(respStr);
      }
    } catch (e) {
      debugPrint('Exception: $e');
      throw Exception('Failed to submit data2: $e');
    }
  }
}
