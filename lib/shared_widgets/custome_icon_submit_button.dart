// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';

class CustomIconSubmitButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  void Function()? onTap;
  CustomIconSubmitButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.icon,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    icon,
                    color: kGrey,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
