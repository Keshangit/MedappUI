import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/services/secure_storage_service.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/landing/sign_in/sign_in.dart';


class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

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
                  'Log Out',
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
                  'Are you sure you want to Log Out from the system?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: kBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                kLogOutImage,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomSubmitButton(
                      title: 'No',
                      color: kGrey,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomSubmitButton(
                      title: 'Yes',
                      color: kBlue,
                      onTap: () {
                        SecureStorageManager().deleteToken();
                        SecureStorageManager().deleteUserId();
                        SecureStorageManager().deleteAll();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                              (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
