import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/landing/sign_in/sign_in.dart';


class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: kWhite,
        surfaceTintColor: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Successful!',
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'New password successfully updated.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              CustomSubmitButton(
                title: 'Continue',
                color: kBlue,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                        (route) => false,
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
