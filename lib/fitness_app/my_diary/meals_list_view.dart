import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps/etap1/etap1_home_screen.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:system_biodairect/model/daily_info.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation, this.etapColor1, this.etapColor2})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final Color? etapColor1, etapColor2;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}


String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
final uid = user!.uid;
DatabaseReference refDailyInfo = FirebaseDatabase.instance.ref('users').child(uid).child('dailyInfo').child(todayDate); 


class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  

  @override
  void initState() {
    getData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    // final event = await refDailyInfo.once(DatabaseEventType.value);
    //   DailyInfo dailyInfo = DailyInfo.fromMap(event.snapshot.value);
    //   if (event.snapshot.value != null) {
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
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Śniadanie',
      kacl: kcalBreakfast,
      time: '8:00 - 9:00',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Przekąska',
      kacl: kcalSnack1,
      time: '13:00 - 14:00',
    ),
     MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Obiad',
      kacl: kcalLunch,
      time: '10:00 - 11:00',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Przekąska',
      kacl: kcalSnack2,
      time: '16:00 - 17:00',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Kolacja',
      kacl: kcalDiner,
      time: '19:00 - 20:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: tabIconsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      tabIconsList.length > 10 ? 10 : tabIconsList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    mealsListData: tabIconsList[index],
                    animation: animation,
                    animationController: animationController!,
                    etapColor1: widget.etapColor1,
                    etapColor2: widget.etapColor2,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.time = '',
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String time;
  int kacl;
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key? key, this.mealsListData, this.animationController, this.animation, this.etapColor1, this.etapColor2})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final Color? etapColor1, etapColor2;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: etapColor2!
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            etapColor1!,
                            etapColor2!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                mealsListData!.time,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        mealsListData!.kacl.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          'kcal',
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 0.2,
                                            color: FitnessAppTheme.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, bottom: 3),
                                        child: Container(
                                          decoration: BoxDecoration(
                                          color: FitnessAppTheme.nearlyWhite,
                                          shape: BoxShape.rectangle,
                                          borderRadius: (BorderRadius.circular(8)),
                                          boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme.nearlyBlack
                                                  .withOpacity(0.4),
                                              offset: Offset(8.0, 8.0),
                                              blurRadius: 8.0),
                                          ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.mode_edit,
                                              color: etapColor2,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData!.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}