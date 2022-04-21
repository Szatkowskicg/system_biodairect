import 'package:system_biodairect/etaps/etap2/etap2_home_screen.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:system_biodairect/settings/settings.dart';
import '../../custom_drawer/drawer_user_controller.dart';
import '../../custom_drawer/home_drawer.dart';
import '../../feedback_screen.dart';
import '../../help_screen.dart';
import '../../invite_friend_screen.dart';
import 'package:flutter/material.dart';

class NavigationEtap2Screen extends StatefulWidget {
  @override
  _NavigationEtap2ScreenState createState() => _NavigationEtap2ScreenState();
}

class _NavigationEtap2ScreenState extends State<NavigationEtap2Screen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomeEtap2();
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
          screenView = const MyHomeEtap2();
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