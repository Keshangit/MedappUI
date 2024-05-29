import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custom_input_feild.dart';
import 'package:med_assist/shared_widgets/custome_email_feild.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/landing/sign_up/local_sign_up_create_password.dart';

class LocalSignUp extends StatefulWidget {
  const LocalSignUp({super.key});

  @override
  State<LocalSignUp> createState() => _LocalSignUpState();
}

class _LocalSignUpState extends State<LocalSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mbasidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      appBar: const CustomAppBar(
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
                  'Local Registration',
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
                        'MBAS ID',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomInputFeild(
                        controller: mbasidController,
                        hintText: '0000-0000-0000-0000',
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
                          builder: (context) => CreatePasswordLocal(
                            name: userNameController.text,
                            dob: dobController.text,
                            mbasiNumber: mbasidController.text,
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
