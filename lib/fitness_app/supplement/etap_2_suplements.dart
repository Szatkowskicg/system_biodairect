import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/ui_view/etap2_view.dart';
import 'package:system_biodairect/fitness_app/ui_view/switches/switch_morning1.dart';
import 'package:flutter/material.dart';
import 'package:system_biodairect/fitness_app/ui_view/title_only_view.dart';
import 'package:system_biodairect/etaps/etap1/etap1_home_screen.dart';
import 'package:system_biodairect/model/suplements_etap1.dart';
import '../fitness_app_theme.dart';

class SuplementEtap2Screen extends StatefulWidget {
  const SuplementEtap2Screen({Key? key, this.animationController, this.countDay}) : super(key: key);

  final String? countDay;
  final AnimationController? animationController;
  @override
  _SuplementEtap2ScreenState createState() => _SuplementEtap2ScreenState();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
final uid = user!.uid;
bool? morning1, morning2, evening1;

class _SuplementEtap2ScreenState extends State<SuplementEtap2Screen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users').child(uid).child('dailyInfo').child(todayDate); 

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

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

  void addAllListData() {
    const int count = 6;
    
    listViews.add(
      Etap2TitleView(
        countDays: 'countDay',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleOnlyView(
        titleTxt: 'Porannek',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SwitchM1View(
        etapColor: FitnessAppTheme.etap2,
        titleTxt: 'Krople hCG Aktywator',
        subTxt: '12 kropli - Przynajmniej 15 min przed lub po posiłku',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SwitchM1View(
        etapColor: FitnessAppTheme.etap2,
        titleTxt: 'Litoral, Błonnik i Sanavit',
        subTxt: 'Do szklanki wsypać 1 łyżeczkę litoralu i zalać 1/3 szklanki wrzątkiem. Po chwili dodać zimnej wody. '
        'Następnie odczekać 5 min i wypić pozostawiając osad na dnie. Popić szklanką wody\n\n'
        '2 Łyżeczki błonnika zalać ciepłą wodą, odczekać zgodnie z zaleceniem na opakowaniu i wypićpopijając szklanką wody z łyżeczką Sanavit',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleOnlyView(
        titleTxt: 'Południe',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SwitchM1View(
        etapColor: FitnessAppTheme.etap2,
        titleTxt: 'Krople hCG Aktywator',
        subTxt: '12 kropli - Przynajmniej 15 min przed lub po posiłku',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleOnlyView(
        titleTxt: 'Wieczór',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SwitchM1View(
        etapColor: FitnessAppTheme.etap2,
        titleTxt: 'Krople hCG Aktywator',
        subTxt: '12 kropli - Przynajmniej 15 min przed lub po posiłku',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SwitchM1View(
        etapColor: FitnessAppTheme.etap2,
        titleTxt: 'Błonnik i Sanavit',
        subTxt: '2 Łyżeczki błonnika zalać ciepłą wodą, odczekać zgodnie z zaleceniem na opakowaniu i wypićpopijając szklanką wody z łyżeczką Sanavit',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    ref.child('users').child(uid).child('dailyInfo').child(todayDate).onValue.listen((event) {
        Suplements suplements = Suplements.fromMap(event.snapshot.value);
        setState(() {
          if (event.snapshot.value != null) {
            morning1 = suplements.morning1!;
            morning2 = suplements.morning2!;
            evening1 = suplements.evening1!;
          } else {
          }
        });
      });
    return true;
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
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
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
      },
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
                                  'Suplementy',
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