import 'package:flutter/material.dart';
import 'package:med_assist/ui/mp/home_page/home_page.dart';
import 'package:med_assist/ui/mp/info/info.dart';
import 'package:med_assist/ui/mp/profile/profile.dart';

class Navigation extends StatefulWidget {
  final String role;
  const Navigation({
    super.key,
    required this.role,
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            HomePage(
              role: widget.role,
            ),
            const Info(),
            const Profile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 18, 99, 165),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Info"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile")
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
      ),
    );
  }
}
