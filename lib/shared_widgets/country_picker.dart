// ignore_for_file: prefer_const_constructors

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';

class CountryPicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChange;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CountryPicker({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Country country = CountryParser.parseCountryName('Sri Lanka');

  void showPicker() {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Colors.blue.shade50,
        ),
        onSelect: (country) {
          setState(() {
            this.country = country;
            widget.controller.text = country.name;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: showPicker,
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
        prefixIcon: Container(
          height: 55,
          width: 100,
          alignment: Alignment.center,
          child: Text(
            country.flagEmoji,
            style: TextStyle(fontSize: 20),
          ),
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
      // cursorColor: kGrey,
      controller: widget.controller,
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
