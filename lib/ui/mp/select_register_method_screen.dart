import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/custom_outline_button.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/landing/sign_up/foreign_sign_up.dart';
import 'package:med_assist/ui/landing/sign_up/local_sign_up.dart';

class SelectRegistrationMethodScreen extends StatelessWidget {
  const SelectRegistrationMethodScreen({super.key});

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
              children: [
                Row(
                  children: [
                    Text(
                      'Let’s get you registered',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Please choose your way of registration to the system.',
                        style: GoogleFonts.inter(
                          color: kLightGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 90,
                ),
                Image.asset(
                  kLandingImage,
                ),
                const SizedBox(
                  height: 200,
                ),
                CustomSubmitButton(
                  title: 'Local Registration',
                  color: kBlue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocalSignUp(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomOutlineSubmitButton(
                  title: 'Foreign Registration',
                  color: kBlue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForeignSignUp(),
                      ),
                    );
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
