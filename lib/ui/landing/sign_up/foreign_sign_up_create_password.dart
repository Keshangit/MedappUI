import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/services/auth_service.dart';
import 'package:med_assist/shared_widgets/custome_password_feild.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/shared_widgets/snak_bars.dart';
import 'package:med_assist/size_config.dart';
import 'package:provider/provider.dart';

class CreatePasswordForeign extends StatefulWidget {
  String? name;
  String? dob;
  String? passportNumber;
  String? country;
  String? email;



   CreatePasswordForeign({
    super.key,
     required this.name,
     required this.dob,
     required this.passportNumber,
     required this.country,
     required this.email,
   });

  @override
  State<CreatePasswordForeign> createState() => _CreatePasswordForeignState();
}

class _CreatePasswordForeignState extends State<CreatePasswordForeign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool validatePassword(String password) {
    RegExp regExp =
    RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
    return regExp.hasMatch(password) && !password.contains(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
              //  SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Row(
                children: [
                  Text(
                    'Create Password',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Please create new password for your account.',
                style: GoogleFonts.inter(
                  color: kBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Create New Password',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomPasswordField(
                      controller: passwordController,
                      hintText: '**********',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'The password must be 8 characters, including 1 uppercase letter, 1 number, and 1 special character, no spaces allowed',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Confirm Password',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomPasswordField(
                      controller: confirmPasswordController,
                      hintText: '**********',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomSubmitButton(
                title: 'Create My Account',
                color: kBlue,
                onTap: () {

                  if (!validatePassword(passwordController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      errorSnackBar(
                          'The password you have entered does not meet the minimum security requirements'),
                    );
                  } else {
                    if (_formKey.currentState!.validate()) {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar('Password do not match'),
                        );
                      } else {
                        Provider.of<AuthenticationService>(context,
                            listen: false)
                            .foreignRegister(
                            context,
                            widget.name.toString(),
                            widget.dob.toString(),
                            widget.passportNumber.toString(),
                            widget.country.toString(),
                            widget.email.toString(),
                            confirmPasswordController.text

                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        )

      ),
    );
  }
}