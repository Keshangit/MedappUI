import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChange;

  const CustomPasswordField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChange});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          Icons.lock_outline,
          color: kGrey,
        ),
        suffixIcon: GestureDetector(
          onTap: toggleObscureText,
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
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
      obscureText: obscureText,
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
