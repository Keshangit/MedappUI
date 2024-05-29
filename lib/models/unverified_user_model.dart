// To parse this JSON data, do
//
//     final unverifiedUserModel = unverifiedUserModelFromJson(jsonString);

import 'dart:convert';

List<UnverifiedUserModel> unverifiedUserModelFromJson(String str) =>
    List<UnverifiedUserModel>.from(
        json.decode(str).map((x) => UnverifiedUserModel.fromJson(x)));

String unverifiedUserModelToJson(List<UnverifiedUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnverifiedUserModel {
  String id;
  String name;
  String email;
  String dob;
  String role;
  String idMbaPass;
  String? country;
  int isVerified;

  UnverifiedUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.role,
    required this.idMbaPass,
    required this.country,
    required this.isVerified,
  });

  factory UnverifiedUserModel.fromJson(Map<String, dynamic> json) =>
      UnverifiedUserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        role: json["role"]!,
        idMbaPass: json["id_mba_pass"],
        country: json["country"] ?? '',
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "dob": dob,
        "role": role,
        "id_mba_pass": idMbaPass,
        "country": country,
        "is_verified": isVerified,
      };
}
