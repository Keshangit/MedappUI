import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';

class CustomOutlineSubmitButtonWithIcon extends StatelessWidget {
  final String title;
  final Color color;
  void Function()? onTap;
  final Widget icon;
  final bool showArrowIcon;
  CustomOutlineSubmitButtonWithIcon({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.icon,
    this.showArrowIcon = true,
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
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: kGrey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        icon,
                        const SizedBox(width: 10,),
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      ],
                    ),
                    if (showArrowIcon)
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kBlack,
                        size: 25,
                      ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}