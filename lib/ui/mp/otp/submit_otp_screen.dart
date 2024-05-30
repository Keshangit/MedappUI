import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/mp/otp/reset_password_screen.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/otp_text_field.dart';

class SubmitOTPScreen extends StatefulWidget {
  String? email;

  SubmitOTPScreen({
    super.key,
    this.email,
  });

  @override
  State<SubmitOTPScreen> createState() => _SubmitOTPScreen();
}

class _SubmitOTPScreen extends State<SubmitOTPScreen> {
  String otpCode = '';
  late Timer _timer;
  int _duration = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_duration == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _duration--;
          });
        }
      },
    );
  }

  void resetTimer() {
    setState(() {
      _duration = 60;
    });
    startTimer();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Submit OTP',
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kVerticalPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: kHorizontalPadding * 2),
                    child: Image.asset(
                      kSubmitOTPImage,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Submit OTP',
                    style: GoogleFonts.inter(
                      color: kBlue,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We have sent you an OTP to your email',
                    style: GoogleFonts.inter(
                      color: kLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'please submit the OTP to reset password',
                    style: GoogleFonts.inter(
                      color: kLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  OTPTextField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    keyboardType: TextInputType.number,
                    length: 4,
                    width: double.maxFinite,
                    fieldWidth: 60,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(
                      backgroundColor: kLightGrey,
                      borderColor: Colors.transparent,
                      disabledBorderColor: Colors.transparent,
                      enabledBorderColor: Colors.transparent,
                      errorBorderColor: Colors.transparent,
                      focusBorderColor: Colors.transparent,
                    ),
                    style: GoogleFonts.urbanist(
                      color: kWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onChanged: (pin) {},
                    onCompleted: (pin) {
                      otpCode = pin;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _duration != 0
                      ? GestureDetector(
                          onTap: () {
                            if (_duration == 0) {
                              resetTimer();
                            }
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Resend OTP in ',
                                  style: GoogleFonts.inter(
                                    color: kBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                                TextSpan(
                                  text: _duration.toString(),
                                  style: GoogleFonts.inter(
                                    color: kBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                                TextSpan(
                                  text: ' s',
                                  style: GoogleFonts.inter(
                                    color: kBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            resetTimer();
                            // Provider.of<AuthenticationService>(context, listen: false).sendOtp(
                            //     context, widget.newEmail.toString(), widget.password.toString());
                          },
                          child: Text(
                            'Resend OTP',
                            style: GoogleFonts.inter(
                              color: kBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8.9,
                  ),
                  CustomSubmitButton(
                    title: 'SUBMIT',
                    color: kBlue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(
                            email: widget.email,
                            otp: otpCode,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
