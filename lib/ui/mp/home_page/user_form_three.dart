import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/dialogs/custome_loading_dialog.dart';
import 'package:med_assist/providers/user_profile_create_provider.dart';
import 'package:med_assist/services/auth_service.dart';
import 'package:med_assist/services/user_form_service.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custom_input_feild.dart';
import 'package:med_assist/shared_widgets/custome_icon_submit_button.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_assist/shared_widgets/snak_bars.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UserFormThree extends StatefulWidget {
  const UserFormThree({super.key});

  @override
  State<UserFormThree> createState() => _UserFormThreeState();
}

class _UserFormThreeState extends State<UserFormThree> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameHospitalController = TextEditingController();
  TextEditingController addressHospitalController = TextEditingController();
  TextEditingController nameDoctorController = TextEditingController();
  TextEditingController dateOfVisitController = TextEditingController();
  List<String> selectedFiles = [];

  List<File> files = [];

  void saveData(BuildContext context) {
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);

    userProfileProvider.updateNameHospital(nameHospitalController.text);
    userProfileProvider.updateAddressHospital(addressHospitalController.text);
    userProfileProvider.updateNameDoctor(nameDoctorController.text);
    userProfileProvider.updateDateOfVisit(dateOfVisitController.text);
    userProfileProvider.updateLikeAppointment(_selectedValue);

    submitProviderData(context);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => UserFormThree(),
    //   ),
    // );
  }

  void submitProviderData(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(
        title: 'Please Wait',
      ),
    );

    try {
      if (mounted) {
        UserProfileProvider userProfileProvider =
            Provider.of<UserProfileProvider>(context, listen: false);
        var response = await UserFormService.userFormSubmit(
          userProfileProvider.firstName!,
          userProfileProvider.middleName!,
          userProfileProvider.lastName!,
          userProfileProvider.email!,
          userProfileProvider.mobile!,
          userProfileProvider.address!,
          userProfileProvider.dob!,
          userProfileProvider.gender!,
          userProfileProvider.mbasid!,
          userProfileProvider.memberType!,
          userProfileProvider.lastSignOffDate!,
          userProfileProvider.medicalProblem!,
          userProfileProvider.symptoms!,
          userProfileProvider.requiredService!,
          userProfileProvider.nameHospital!,
          userProfileProvider.addressHospital!,
          userProfileProvider.nameDoctor!,
          userProfileProvider.dateOfVisit!,
          userProfileProvider.likeAppointment!,
          userProfileProvider.uploadedFiles!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          successSnackBar(response),
        );
        userProfileProvider.clearData();

        print(response);
      }
      Navigator.pop(context);
      AuthenticationService().applicationInit(context);

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const UserForm(),
      //   ),
      //   (route) => false,
      // );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Unable to Save Data: $e'),
        );
      }
      Navigator.pop(context);
    }
  }

  String? _selectedValue;
  final List<String> _dropdownItems = [
    'Yes',
    'No',
  ];

  Future<void> _pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docs',
        'docx',
        'xlsx'
      ],
    );
    if (result != null) {
      if (selectedFiles.isEmpty) {
        setState(() {
          selectedFiles = result.paths.take(3).map((path) => path!).toList();
        });
      } else {
        setState(() {
          final newPaths = result.paths
              .take(3 - selectedFiles.length)
              .map((path) => path!)
              .toList();
          selectedFiles.addAll(newPaths);
        });
      }

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        files = files.take(3).toList(); // Limit to 3 files

        Provider.of<UserProfileProvider>(context, listen: false)
            .updateUploadedFiles(files);

        setState(() {
          selectedFiles = files.map((file) => file.path).toList();
        });
      }

      // if (result != null) {
      //   // Filter out null values and convert to List<String>
      //   List<String> filePaths = result.paths
      //       .where((path) => path != null)
      //       .cast<String>()
      //       .take(3)
      //       .toList();
      //   Provider.of<UserProfileProvider>(context, listen: false)
      //       .updateUploadedFiles(filePaths);
      // }
      // Provider.of<UserProfileProvider>(context, listen: false)
      //     .updateUploadedFiles(selectedFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1800),
        lastDate: DateTime(3100),
        initialDate: DateTime.now(),
      );
      if (picked != null) {
        setState(() {
          dateOfVisitController.text = DateFormat('dd/MM/yyyy').format(picked);
        });
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        showTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Local User Form',
                style: GoogleFonts.inter(
                  color: kBlack,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Appointment Preferences',
                style: GoogleFonts.inter(
                  color: kLightGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hospital / Clinic Name',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: nameHospitalController,
                      hintText: 'Enter here',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Address of the Hospital / Clinic',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: addressHospitalController,
                      hintText: 'Enter here',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Name of the Doctor',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: nameDoctorController,
                      hintText: 'Enter here',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Date of Visit',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: dateOfVisitController,
                      hintText: 'DD/MM//YYYY',
                      suffixIcon: Icons.date_range,
                      onTap: selectDate,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Would you like MedAssist to arrange a channel appointment for you?',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedValue,
                      hint: Text(
                        'Select',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      items: _dropdownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: kGrey,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: kGrey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Attachments',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomIconSubmitButton(
                      title: 'Upload Files',
                      color: kBlack,
                      icon: Icons.file_upload_outlined,
                      onTap: () {
                        _pickFiles(context);
                      },
                    ),
                    selectedFiles.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: selectedFiles
                                      .map(
                                        (selectedFile) => Container(
                                          width: 150,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: kGrey,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  basename(
                                                    selectedFile,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                    color: kBlack,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedFiles
                                                        .remove(selectedFile);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: kBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomSubmitButton(
                title: 'Submit',
                color: kBlue,
                onTap: () {
                  saveData(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
