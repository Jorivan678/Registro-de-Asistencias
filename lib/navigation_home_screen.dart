import 'package:app_dummy_10a/app_theme.dart';
import 'package:app_dummy_10a/custom_drawer/drawer_user_controller.dart';
import 'package:app_dummy_10a/custom_drawer/home_drawer.dart';
import 'package:app_dummy_10a/principal_pages/reportList_screen.dart';
import 'package:app_dummy_10a/principal_pages/assist_home_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  final bool indicator;
  const NavigationHomeScreen({Key? key, required this.indicator})
      : super(key: key);

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    if (widget.indicator == true) {
      drawerIndex = DrawerIndex.HOME;
      screenView = const AssistHomeScreen();
    } else {
      drawerIndex = DrawerIndex.Report;
      screenView = const ReportListScreen();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const AssistHomeScreen();
          });
          break;
        case DrawerIndex.Report:
          setState(() {
            screenView = const ReportListScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
