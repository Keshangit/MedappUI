import 'package:flutter/material.dart';
import 'package:med_assist/dialogs/custome_loading_dialog.dart';
import 'package:med_assist/models/unverified_user_model.dart';
import 'package:med_assist/services/admin_service.dart';
import 'package:med_assist/shared_widgets/snak_bars.dart';
import 'package:med_assist/ui/mp/request_details/request_details.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List<UnverifiedUserModel> _unverifiedUsers = [];
  late RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => _getUnverifiedUsers());
  }

  Future<void> _refresh() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    _getUnverifiedUsers();
    _refreshController.refreshCompleted();
  }

  Future<void> _getUnverifiedUsers() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(
        title: 'Please Wait',
      ),
    );
    try {
      final users = await AdminService.getUnverifiedList(context);
      if (mounted) {
        Navigator.pop(context);
        setState(() {
          _unverifiedUsers = users;
        });
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Unable to get Data: $error'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: _refresh,
      header: const WaterDropMaterialHeader(
        backgroundColor: Colors.blue,
        color: Colors.white,
        distance: 20.0,
      ),
      child: _unverifiedUsers.isEmpty
          ? Center(
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/icons/no_data.png",
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _unverifiedUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestDetails(
                          unverifiedUser: _unverifiedUsers[index],
                        ),
                      ),
                    ).then((value) => _getUnverifiedUsers());
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_640.png'),
                      ),
                      title: Text(_unverifiedUsers[index].name),
                      subtitle: Text(
                          "${_unverifiedUsers[index].email},  ${_unverifiedUsers[index].idMbaPass}"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
