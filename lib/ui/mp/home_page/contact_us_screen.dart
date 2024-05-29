import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/dialogs/call_center_dialog.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                kCallCenterMethod,
              ),
              Text(
                'Hi Johon',
                style: GoogleFonts.inter(
                  color: kBlack,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Please Contact Us for more information',
                style: GoogleFonts.inter(
                  color: kBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Expanded(
                child: Center(
                  child: CustomSubmitButton(
                    title: 'Contact Call Center',
                    color: kBlue,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CallCenterDialog(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
