class UserProfile {
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
  String? requiedService;
  String? nameHospital;
  String? addressHospital;
  String? nameDoctor;
  String? dateOfVisit;
  String? likeAppoinment;
  List<String>? uploadedFiles;

  UserProfile({
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.mobile,
    this.address,
    this.dob,
    this.gender,
    this.mbasid,
    this.memberType,
    this.lastSignOffDate,
    this.medicalProblem,
    this.symptoms,
    this.requiedService,
    this.nameHospital,
    this.addressHospital,
    this.nameDoctor,
    this.dateOfVisit,
    this.likeAppoinment,
    this.uploadedFiles = const [],
  });
}
