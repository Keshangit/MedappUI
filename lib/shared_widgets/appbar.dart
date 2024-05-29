import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLeadingIcon;
  final bool showTitle;

  const CustomAppBar({
    super.key,
     this.title,
    this.showLeadingIcon = true,
    this.showTitle = true, // Set default value to true
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      surfaceTintColor: kWhite,
      backgroundColor: kWhite,
      foregroundColor: kWhite,
      shadowColor: kWhite,
      title: widget.showTitle
          ? Text(
              widget.title.toString(),
              style: GoogleFonts.inter(
                color: kBlack,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      centerTitle: true,
      leading: widget.showLeadingIcon
          ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(kBackIcon))
          : null, // Set leading to null if showLeadingIcon is false
    );
  }
}
