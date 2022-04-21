import 'package:system_biodairect/etaps/etap3/etap3_home_screen.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:system_biodairect/settings/settings.dart';
import '../../custom_drawer/drawer_user_controller.dart';
import '../../custom_drawer/home_drawer.dart';
import '../../feedback_screen.dart';
import '../../help_screen.dart';
import '../../invite_friend_screen.dart';
import 'package:flutter/material.dart';

class NavigationEtap3Screen extends StatefulWidget {
  @override
  _NavigationEtap3ScreenState createState() => _NavigationEtap3ScreenState();
}

class _NavigationEtap3ScreenState extends State<NavigationEtap3Screen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomeEtap3();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: FitnessAppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: FitnessAppTheme.nearlyWhite,
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
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomeEtap3();
        });
      } else if (drawerIndex == DrawerIndex.Settings) {
        setState(() {
          screenView = SettingsScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}