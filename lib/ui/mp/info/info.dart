import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  'App Info',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Text(
                  'Test',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(
                  height:  30,
                ),
                Center(
                  child: Image.asset(
                    kLogoWithOutBGImage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
