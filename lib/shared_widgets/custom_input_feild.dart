import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';

class CustomInputFeild extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChange;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;

  const CustomInputFeild({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  });

  @override
  State<CustomInputFeild> createState() => _CustomInputFeildState();
}

class _CustomInputFeildState extends State<CustomInputFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.onTap != null,
      onTap: widget.onTap,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kGrey,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: kGrey,
          // size: 25.h,
        ),
        suffixIcon: Icon(
          widget.suffixIcon,
          color: kGrey,
          // size: 25.h,
        ),
        suffixIconColor: kGrey,
      ),
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value); // Call the onChange function
        }
      },
      cursorColor: kGrey,
      controller: widget.controller,
      // obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill this field to continue';
        } else {
          return null;
        }
      },
    );
  }
}
