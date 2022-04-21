import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/ui_view/etap2_view.dart';
import 'package:system_biodairect/fitness_app/ui_view/scale_etap3_view.dart';
import 'package:system_biodairect/fitness_app/ui_view/title_only_view.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:system_biodairect/fitness_app/my_diary/water_view.dart';
import 'package:flutter/material.dart';
import 'package:system_biodairect/model/daily_info.dart';

class MyDiaryEtap3 extends StatefulWidget {
  const MyDiaryEtap3({Key? key, this.animationController, this.countDay}) : super(key: key);

  final String? countDay;
  final AnimationController? animationController;
  @override
  _MyDiaryEtap3State createState() => _MyDiaryEtap3State();
}

class _MyDiaryEtap3State extends State<MyDiaryEtap3>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final uid = user!.uid;
  
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  String formatDate = DateFormat.MMMd().format(DateTime.now());

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    
    

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  Stream<Future> getData() async* {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    FirebaseDatabase.instance
                  .ref()
                  .child('users')
                  .child(uid)
                  .child('dailyInfo')
                  .child(todayDate)
                  .onValue.listen((event) {
                    DailyInfo dailyInfo = DailyInfo.fromMap(event.snapshot.value);
                    print('Snapshot: ${dailyInfo.scale}');
                    final waga = dailyInfo.scale as int;
                    const int count = 11;
                    listViews.add(
                      Etap2TitleView(
                        countDays: '3',
                        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                            parent: widget.animationController!,
                            curve:
                                const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
                        animationController: widget.animationController!,
                      ),
                    );
                    listViews.add(
                      TitleOnlyView(
                        titleTxt: 'Poranna kontrola wagi',
                        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                            parent: widget.animationController!,
                            curve:
                                const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
                        animationController: widget.animationController!,
                      ),
                    );
                    listViews.add(
                      ScaleEtap3View(
                        kcal: waga,
                        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                            parent: widget.animationController!,
                            curve:
                                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
                        animationController: widget.animationController!,
                      ),
                    );
                  });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return StreamBuilder(
      stream: getData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      36,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                itemCount: listViews.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  widget.animationController?.forward();
                  return listViews[index];
                },
              );
      }
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(0, 5),
                          blurRadius: 5.0, 
                          spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 40 - 8.0 * topBarOpacity,
                            bottom: 20 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Dziennik',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: FitnessAppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    formatDate,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}