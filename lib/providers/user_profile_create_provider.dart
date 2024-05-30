import 'dart:io';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? dob;
  String? gender;
  String? mbasid;
  String? memberType;
  String? lastSignOffDate;
  String? medicalProblem;
  String? symptoms;
  String? requiredService;
  String? nameHospital;
  String? addressHospital;
  String? nameDoctor;
  String? dateOfVisit;
  String? likeAppointment;
  List<File>? uploadedFiles = [];

  void updateFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void updateMiddleName(String value) {
    middleName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updateMobile(String value) {
    mobile = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  void updateDob(String value) {
    dob = value;
    notifyListeners();
  }

  void updateGender(String value) {
    gender = value;
    notifyListeners();
  }

  void updateMbasid(String value) {
    mbasid = value;
    notifyListeners();
  }

  void updateMemberType(String value) {
    memberType = value;
    notifyListeners();
  }

  void updateLastSignOffDate(String value) {
    lastSignOffDate = value;
    notifyListeners();
  }

  void updateMedicalProblem(String value) {
    medicalProblem = value;
    notifyListeners();
  }

  void updateSymptoms(String value) {
    symptoms = value;
    notifyListeners();
  }

  void updateRequiredService(String value) {
    requiredService = value;
    notifyListeners();
  }

  void updateNameHospital(String value) {
    nameHospital = value;
    notifyListeners();
  }

  void updateAddressHospital(String value) {
    addressHospital = value;
    notifyListeners();
  }

  void updateNameDoctor(String value) {
    nameDoctor = value;
    notifyListeners();
  }

  void updateDateOfVisit(String value) {
    dateOfVisit = value;
    notifyListeners();
  }

  void updateLikeAppointment(String? value) {
    likeAppointment = value;
    notifyListeners();
  }

  void updateUploadedFiles(List<File> files) {
    uploadedFiles = files;
    notifyListeners();
  }

  // Method to clear the provider data
  void clearData() {
    firstName = null;
    middleName = null;
    lastName = null;
    email = null;
    mobile = null;
    address = null;
    dob = null;
    gender = null;
    mbasid = null;
    memberType = null;
    lastSignOffDate = null;
    medicalProblem = null;
    symptoms = null;
    requiredService = null;
    nameHospital = null;
    addressHospital = null;
    nameDoctor = null;
    dateOfVisit = null;
    likeAppointment = null;
    uploadedFiles = [];
    notifyListeners();
  }
}
