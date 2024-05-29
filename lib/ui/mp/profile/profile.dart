import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/dialogs/confirm_logout_dialog.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custom_outline_submit_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController imagePathController = TextEditingController();
  bool imageChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showLeadingIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                kProfileHolder,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              height: 20,
            ),
            CustomOutlineSubmitButtonWithIcon(
              title: 'Change Password',
              color: kBlack,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChangePasswordScreen(),
                //   ),
                // );
              },
              icon: Image.asset(
                kChangePasswordIcon,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomOutlineSubmitButtonWithIcon(
              title: 'Logout',
              color: kBlack,
              showArrowIcon: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const ConfirmLogoutDialog(),
                );
              },
              icon: Image.asset(
                kLogOutIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
