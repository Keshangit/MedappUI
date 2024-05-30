import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/providers/user_profile_create_provider.dart';
import 'package:med_assist/shared_widgets/custom_input_feild.dart';
import 'package:med_assist/shared_widgets/custome_email_feild.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';
import 'package:med_assist/ui/mp/home_page/user_form_two.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mbasidController = TextEditingController();
  TextEditingController lastSignOffDateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime(3100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectsignInDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime(3100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        lastSignOffDateController.text =
            DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  String _selectedGender = 'Male'; // Default selected value

  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value!;
    });
  }

  String _selectMember = 'Yes'; // Default selected value

  void _handleMemberChange(String? value) {
    setState(() {
      _selectMember = value!;
    });
  }

  void saveData() {
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);

    userProfileProvider.updateFirstName(firstNameController.text);
    userProfileProvider.updateMiddleName(middleNameController.text);
    userProfileProvider.updateLastName(lastNameController.text);
    userProfileProvider.updateEmail(emailController.text);
    userProfileProvider.updateMobile(mobileController.text);
    userProfileProvider.updateAddress(addressController.text);
    userProfileProvider.updateDob(dobController.text);
    userProfileProvider.updateGender(_selectedGender);
    userProfileProvider.updateMbasid(mbasidController.text);
    userProfileProvider.updateMemberType(_selectMember);
    userProfileProvider.updateLastSignOffDate(lastSignOffDateController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserFormTwo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Local User Form',
                style: GoogleFonts.inter(
                  color: kBlack,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Please fill the below Form',
                style: GoogleFonts.inter(
                  color: kLightGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: firstNameController,
                      hintText: 'Enter your first Name',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Middle Name',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: middleNameController,
                      hintText: 'Enter your middle Name',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Last Name(Sure Name)',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: lastNameController,
                      hintText: 'Enter your last Name',
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'Email Address',
                          style: GoogleFonts.inter(
                            color: kBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomEmailField(
                      controller: emailController,
                      hintText: 'example@gmail.com',
                      validate: true,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Telephone No',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: mobileController,
                      hintText: '+94 77 777 7777',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Postal Address',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: addressController,
                      hintText: 'Enter your address',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Enter Date of Birth',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: dobController,
                      hintText: 'DD/MM//YYYY',
                      suffixIcon: Icons.date_range,
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Sex',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: _handleGenderChange,
                    ),
                    RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: _handleGenderChange,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'MBAS ID',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: mbasidController,
                      hintText: '0000-0000-0000-0000',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Is the principle member of the patient?',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RadioListTile<String>(
                      title: const Text('Yes'),
                      value: 'Yes',
                      groupValue: _selectMember,
                      onChanged: _handleGenderChange,
                    ),
                    RadioListTile<String>(
                      title: const Text('No'),
                      value: 'No',
                      groupValue: _selectMember,
                      onChanged: _handleGenderChange,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'If yes, Last signed-off date from the vessel',
                      style: GoogleFonts.inter(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomInputFeild(
                      controller: lastSignOffDateController,
                      hintText: 'DD/MM//YYYY',
                      suffixIcon: Icons.date_range,
                      onTap: _selectsignInDate,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomSubmitButton(
                title: 'Next',
                color: kBlue,
                onTap: () {
                  saveData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
