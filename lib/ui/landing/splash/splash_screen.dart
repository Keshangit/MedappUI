import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/services/auth_service.dart';
import 'package:med_assist/size_config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthenticationService>(context, listen: false).checkLogin(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: kGrey,
          statusBarColor: kGrey,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: kGrey,
        statusBarColor: kGrey,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
       color: kWhite
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 40),
              Image.asset(
                kLogoWithOutBGImage,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
              Text(
                'Visitiora',
                style: GoogleFonts.inter(
                  color: kWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              //SizedBox(height: 40),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
                    // Adjust bottom padding as needed
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                        colors: [
                          kBlue,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
