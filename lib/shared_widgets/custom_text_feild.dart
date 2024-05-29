// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? validate;
  final bool? readOnly;
  final bool? keyboardType;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.validate,
      this.readOnly,
      this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextInputType _getKeyboardType() {
    if (widget.keyboardType == true) {
      return TextInputType.numberWithOptions(decimal: true);
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly == true ? kGrey : kGrey,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.readOnly == true ? kGrey : kGrey,
        ),
      ),
      readOnly: widget.readOnly ?? false,
      cursorColor: kGrey,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: _getKeyboardType(),
      validator: (value) {
        if (widget.validate != null &&
            widget.validate == true &&
            value!.isEmpty) {
          return 'Please fill this field to continue';
        } else {
          return null;
        }
      },
    );
  }
}
