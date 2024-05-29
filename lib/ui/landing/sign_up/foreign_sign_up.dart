// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/country_picker.dart';
import 'package:med_assist/shared_widgets/custom_input_feild.dart';
import 'package:med_assist/shared_widgets/custome_email_feild.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/landing/sign_up/foreign_sign_up_create_password.dart';

class ForeignSignUp extends StatefulWidget {
  const ForeignSignUp({super.key});

  @override
  State<ForeignSignUp> createState() => _ForeignSignUpState();
}

class _ForeignSignUpState extends State<ForeignSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passPortNumController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime(3100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Foreign Registration',
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Please fill the below information to register to the system.',
                  style: GoogleFonts.inter(
                    color: kLightGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Name',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomInputFeild(
                        controller: userNameController,
                        hintText: 'John',
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Enter Date of Birth',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomInputFeild(
                        controller: dobController,
                        hintText: 'DD/MM//YYYY',
                        suffixIcon: Icons.date_range,
                        onTap: _selectDate,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Passport Number',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomInputFeild(
                        controller: passPortNumController,
                        hintText: '0000-0000-0000',
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Select Country',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CountryPicker(
                        controller: countryController,
                        hintText: 'Sri Lanka',
                        suffixIcon: Icons.keyboard_arrow_down_sharp,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Email Address',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomEmailField(
                  controller: emailController,
                  hintText: 'example@gmail.com',
                  validate: true,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 10.2,
                ),
                // const Spacer(),
                CustomSubmitButton(
                  title: 'Next',
                  color: kBlue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePasswordForeign(
                            name: userNameController.text,
                            dob: dobController.text,
                            passportNumber: passPortNumController.text,
                            country: countryController.text,
                            email: emailController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
