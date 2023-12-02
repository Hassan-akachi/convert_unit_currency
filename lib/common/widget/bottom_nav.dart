import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:convert_unit_currency/features/Category/screen/all_category_screen.dart';
import 'package:convert_unit_currency/features/settings/screen/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../constant/color.dart';
import '../../features/home/screen/home_screen.dart';

class BottomNav extends StatefulWidget {
  static const String routeName = "/actual-home";

  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 1;
  double BottomNavWidth = 42;
  double BottomNavBorderWidth = 5;

//check for internet
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  List<Widget> pages = [
    const AllCategoryScreen(),
    const HomeScreen(),
    const SettingScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalColor.selectedNavBarColor,
        unselectedItemColor: GlobalColor.unselectedNavBarColor,
        backgroundColor: GlobalColor.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: BottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalColor.selectedNavBarColor
                        : GlobalColor.backgroundColor,
                    width: BottomNavBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.list_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: BottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalColor.selectedNavBarColor
                        : GlobalColor.backgroundColor,
                    width: BottomNavBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: BottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalColor.selectedNavBarColor
                        : GlobalColor.backgroundColor,
                    width: BottomNavBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.settings_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
  performAsyncWork() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;

    // Perform async work outside setState
    if (!isConnected && !isAlertSet) {
      showDialogBox();
      setState(() {
        isAlertSet = true;
      });
    }
  }
  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text("Please check your internet connection"),
            actions: [TextButton(onPressed: () {

              Navigator.pop(context,"Cancel");
              setState(() async {
                isAlertSet=false;
                isDeviceConnected =await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  showDialogBox();
                  setState(() {
                    isAlertSet= true;
                  });
                }
              });
            }, child: const Text("ok",style: TextStyle(),))],
          ));
}
