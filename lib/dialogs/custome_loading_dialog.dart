import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:med_assist/constants.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String title;
  const CustomLoadingDialog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [
                  kBlack,
                ],
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: kGrey,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
