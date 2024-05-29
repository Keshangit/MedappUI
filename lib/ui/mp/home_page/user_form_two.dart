import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/mp/home_page/user_form_three.dart';

import '../../../shared_widgets/text_area.dart';

class UserFormTwo extends StatefulWidget {
  const UserFormTwo({super.key});

  @override
  State<UserFormTwo> createState() => _UserFormTwoState();
}

class _UserFormTwoState extends State<UserFormTwo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mbasidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController medicalProblemController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();

  String? _selectedValue;
  final List<String> _dropdownItems = [
    'Outpatient Service',
    'Inpatient Service',
  ];

  @override
  Widget build(BuildContext context) {
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
                'Medical Details',
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
                      'Describe your medical Problems / symptoms you feel',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomMultilineTextField(
                      controller: medicalProblemController,
                      hintText: 'Describe here',
                      lineCount: 5,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Duration of Symptoms',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomMultilineTextField(
                      controller: symptomsController,
                      hintText: 'Describe here',
                      lineCount: 5,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Select Required Service',
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
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomSubmitButton(
                title: 'Next',
                color: kBlue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserFormThree(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
