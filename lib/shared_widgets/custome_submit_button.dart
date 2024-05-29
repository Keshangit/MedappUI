import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';

class CustomSubmitButton extends StatelessWidget {
  final String title;
  final Color color;
  void Function()? onTap;
  CustomSubmitButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}