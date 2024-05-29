import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';

import 'package:url_launcher/url_launcher.dart';

class CallCenterDialog extends StatelessWidget {
  const CallCenterDialog({super.key});

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
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Med Assist Call Center',
                        style: GoogleFonts.inter(
                          color: kBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              Image.asset(
                kCallCenter,
              ),
              CustomSubmitButton(
                title: 'Call Now +94 11 234 5678',
                color: kBlue,
                onTap: () async {
                  final Uri callUrl = Uri(
                    scheme: 'tel',
                    path: '+94112345678',
                  );
                  if (await canLaunchUrl(callUrl)) {
                    await launchUrl(callUrl);
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri mailUrl = Uri(
                    scheme: 'mailto',
                    path: 'info@aventagelabs.com',
                    query: encodeQueryParameters(
                      <String, String>{
                        'subject': 'Call center help query',
                        'body': '',
                      },
                    ),
                  );
                  if (await canLaunchUrl(mailUrl)) {
                    await launchUrl(mailUrl);
                  }
                },
                child: Text(
                  'Info@medassist.com',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
