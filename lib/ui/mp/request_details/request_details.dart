import 'package:flutter/material.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/dialogs/custome_loading_dialog.dart';
import 'package:med_assist/models/unverified_user_model.dart';
import 'package:med_assist/services/admin_service.dart';
import 'package:med_assist/shared_widgets/appbar.dart';
import 'package:med_assist/shared_widgets/custome_submit_button.dart';

class RequestDetails extends StatefulWidget {
  final UnverifiedUserModel unverifiedUser;

  const RequestDetails({
    super.key,
    required this.unverifiedUser,
  });

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  bool isForign = false;

  void _verifyUserAccount(String userId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(
        title: 'Verifying Account',
      ),
    );

    try {
      final response = await AdminService.verifyAccount(context, userId);
      // Navigator.pop(context);
      if (response['title'] == 'Success') {
        if (mounted) {
          Navigator.pop(context);
          Navigator.of(context).pop();
          showSuccessDialog(context, accepted: true);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  response['message'] ?? 'User account verified successfully.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 350,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              'https://media.istockphoto.com/id/1347495868/photo/smiling-african-american-man-wearing-glasses.jpg?s=612x612&w=0&k=20&c=QMCbWu-AOfLDkQMsX-qX2xHFZAL56tx_uVucZ5rBxv8=',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Text(
                            widget.unverifiedUser.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _dataLine(true, "Date Of Birth ", widget.unverifiedUser.dob),
                const SizedBox(
                  height: 5,
                ),
                _dataLine(
                    widget.unverifiedUser.country == "Srilanka" ? true : false,
                    "MBIS ID ",
                    widget.unverifiedUser.idMbaPass),
                const SizedBox(
                  height: 5,
                ),
                _dataLine(
                    widget.unverifiedUser.country == "Srilanka" ? false : true,
                    "Passport No ",
                    widget.unverifiedUser.idMbaPass),
                const SizedBox(
                  height: 5,
                ),
                _dataLine(
                    widget.unverifiedUser.country == "Srilanka" ? false : true,
                    "Country ",
                    widget.unverifiedUser.country!),
                const Spacer(),
                CustomSubmitButton(
                  title: 'Approve',
                  color: kBlue,
                  onTap: () {
                    _confirmdialog(context, true);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomSubmitButton(
                  title: 'Reject',
                  color: Colors.red,
                  onTap: () {
                    _confirmdialog(context, false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _confirmdialog(BuildContext context, bool isApprove) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            isApprove ? 'Accept Request' : "Reject Request",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(isApprove
                        ? 'Please Confirm acceptance by pressing the Confirm button'
                        : 'Please Confirm Rejection by pressing the Confirm button'),
                    const SizedBox(height: 24),
                    Center(
                      child: CustomSubmitButton(
                        title: 'Confirm',
                        color: isApprove ? kBlue : Colors.red,
                        onTap: () {
                          // Navigator.of(context).pop();
                          if (isApprove) {
                            _verifyUserAccount(widget.unverifiedUser.id);
                            Navigator.of(context).pop();

                            // showSuccessDialog(context, accepted: true);
                          } else {
                            showSuccessDialog(context, accepted: false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, {bool accepted = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                accepted
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 80.0,
                      )
                    : const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 80.0,
                      ),
                Text(
                  accepted ? 'Success' : 'Rejected',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  accepted
                      ? 'Request has Successfully accepted!'
                      : 'Request has Successfully rejected!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Visibility _dataLine(bool isVisible, String title, String data) {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$title : ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              TextSpan(
                text: data,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
