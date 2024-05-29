import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/services/auth_service.dart';
import 'package:med_assist/shared_widgets/custome_email_feild.dart';
import 'package:med_assist/shared_widgets/custome_password_feild.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/shared_widgets/snak_bars.dart';
// ignore: unused_import
import 'package:med_assist/ui/mp/otp/submit_otp_screen.dart';
import 'package:med_assist/ui/mp/select_register_method_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileCountryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Let’s Sign you In',
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Please insert your login details to sign in to the system.',
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
                    children: [
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
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            'Enter Your Password',
                            style: GoogleFonts.inter(
                              color: kBlack,
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            errorSnackBar('Please Fill the Email Address'),
                          );
                        } else {
                          Provider.of<AuthenticationService>(context,
                                  listen: false)
                              .sendOtp(context, emailController.text);
                        }
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>  SubmitOTPScreen(
                        //         email: emailController.text,
                        //       ),
                        //     ),
                        //   );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.inter(
                          color: kGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.2,
                ),
                // const Spacer(),
                CustomSubmitButton(
                  title: 'LOGIN',
                  color: kBlue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      AuthenticationService().login(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: GoogleFonts.notoSansBengali(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SelectRegistrationMethodScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.notoSansBengali(
                          color: kBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
