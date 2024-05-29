import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
class RegistrationCompleteDialog extends StatelessWidget {
  const RegistrationCompleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: kWhite,
        surfaceTintColor: kGrey,
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
                  'Congratulations!',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Your account has been successfully created.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                kSuccessImage,
              ),
              const SizedBox(height: 10),
              CustomSubmitButton(
                title: 'Continue',
                color: kBlue,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
