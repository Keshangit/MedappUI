import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';

class CustomMultilineTextField extends StatefulWidget {
  final TextEditingController controller;
  final int lineCount;
  final String hintText;
  final bool? validate;
  const CustomMultilineTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validate,
    required this.lineCount,
  });

  @override
  State<CustomMultilineTextField> createState() => _CustomMultilineTextFieldState();
}

class _CustomMultilineTextFieldState extends State<CustomMultilineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.lineCount,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kGrey,
        ),
      ),
      cursorColor: kGrey,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.validate != null && widget.validate == true && value!.isEmpty) {
          return 'Please fill this field to continue';
        } else {
          return null;
        }
      },
    );
  }
}
