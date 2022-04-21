import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/my_diary/my_diary_etap3.dart';
import 'package:system_biodairect/fitness_app/supplement/etap_2_suplements.dart';
import 'package:system_biodairect/model/daily_info.dart';
import 'package:system_biodairect/model/tabIcon_data.dart';
import '../../fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import '../../fitness_app/fitness_app_theme.dart';

class MyHomeEtap3 extends StatefulWidget {
  const MyHomeEtap3({Key? key}) : super(key: key);

  @override
  _MyHomeEtap3State createState() => _MyHomeEtap3State();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final uid = user!.uid;

DateTime? startDate;

int kcalBreakfast = 0;
int kcalSnack1 = 0;
int kcalLunch = 0;
int kcalSnack2 = 0;
int kcalDiner = 0;
int scale = 0;


class _MyHomeEtap3State extends State<MyHomeEtap3> with TickerProviderStateMixin {
  late StreamSubscription _dailyDataStrem;
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  final uid = user!.uid;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryEtap3(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    _dailyDataStrem = 
      ref.child('users').child(uid).child('dailyInfo').onValue.listen((event) {
        DailyInfo dailyInfo = DailyInfo.fromMap(event.snapshot.value);
        setState(() {
          if (event.snapshot.value != null) {
            assert (dailyInfo.scale != null);
            scale = dailyInfo.scale as int;
          } else {
          }
        });
      });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return Stack(
                          children: <Widget>[
                          tabBody,
                          bottomBar(),
                          ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryEtap3(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      SuplementEtap2Screen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      SuplementEtap2Screen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      SuplementEtap2Screen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

   @override
  void deactivate() {
    _dailyDataStrem.cancel();
    super.deactivate();
  }
}