import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/recipes/recipes_main.dart';
import 'package:system_biodairect/fitness_app/statistics/calendar.dart';
import 'package:system_biodairect/model/tabIcon_data.dart';
import '../../fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../fitness_app/my_diary/my_diary_etap1.dart';
import '../../fitness_app/supplement/etap1_suplements.dart';

class MyHomeEtap1 extends StatefulWidget {
  const MyHomeEtap1({Key? key}) : super(key: key);

  @override
  _MyHomeEtap1State createState() => _MyHomeEtap1State();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
final uid = user!.uid;

int kcalBreakfast = 0; 
int kcalSnack1 = 0;
int kcalLunch = 0;
int kcalSnack2 = 0;
int kcalDiner = 0;
// int scale = 0;


class _MyHomeEtap1State extends State<MyHomeEtap1> with TickerProviderStateMixin {
  // late StreamSubscription _dailyDataStrem;
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  DatabaseReference refDailyInfo = FirebaseDatabase.instance.ref('users').child(uid).child('dailyInfo').child(todayDate); 

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
    tabBody = MyDiaryEtap1(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    // _dailyDataStrem = 
    //   ref.child('users').child(uid).child('dietDate').onValue.listen((event) {
    //     DietModel dietModel = DietModel.fromMap(event.snapshot.value);
    //     setState(() {
    //       if (event.snapshot.value != null) {
    //         assert (dietModel.startDate != null);
    //         startDate = parseToDate(dietModel.startDate.toString());
    //         countDay = countDays(startDate!, DateTime.now()).toString();
    //       } else {
    //       }
    //     });
    //   });
    //   final event2 = await refDailyInfo.once(DatabaseEventType.value);
    //   DailyInfo dailyInfo = DailyInfo.fromMap(event2.snapshot.value);
    //   if (event2.snapshot.value != null) {
    //     if (dailyInfo.scale != null){scale = dailyInfo.scale as int;}
    //     if (dailyInfo.kcalBreakfast != null){kcalBreakfast = dailyInfo.kcalBreakfast as int;}
    //     if (dailyInfo.kcalSnack1 != null){kcalSnack1 = dailyInfo.kcalSnack1 as int;}
    //     if (dailyInfo.kcalLunch != null){kcalLunch = dailyInfo.kcalLunch as int;}
    //     if (dailyInfo.kcalSnack2 != null){kcalSnack2 = dailyInfo.kcalSnack2 as int;}
    //     if (dailyInfo.kcalDiner != null){kcalDiner = dailyInfo.kcalDiner as int;}
    //   } else {
    //   }
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
                      MyDiaryEtap1(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      CalendarHomeScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      RecipeHomeScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

  //  @override
  // void deactivate() {
  //   _dailyDataStrem.cancel();
  //   super.deactivate();
  // }
}