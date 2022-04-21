import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/boarding.dart';
import 'package:system_biodairect/etaps/etap3/navigation_etap3_screen.dart';
import 'package:system_biodairect/etaps/etap4.dart';
import 'package:system_biodairect/etaps/etap5.dart';
import 'package:system_biodairect/etaps/etap2/navigation_etap2_screen.dart';
import 'package:system_biodairect/model/diet_sett.dart';
import 'package:system_biodairect/etaps/etap1/navigation_etap1_screen.dart';

class EtapWrapper extends StatefulWidget {
  @override
  _EtapWrapperState createState() => _EtapWrapperState();
}

bool? boarding;
bool isLoaded = false;
DateTime? startDate;
DateTime? nowDate = DateTime.now();
int? e1, e2, e3, e4, count;
User? user = FirebaseAuth.instance.currentUser;
final ref = FirebaseDatabase.instance.ref();
final uid = user!.uid;

class _EtapWrapperState extends State<EtapWrapper> {
  late StreamSubscription _etapsStrem;

  @override
  void initState() {
    checkBoarding();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => isLoaded
    ? etaps() 
    : const Scaffold(body: Center(child: CircularProgressIndicator(),),);

  void checkBoarding() {
    _etapsStrem = 
      ref.child('users').child(uid).child('dietDate').onValue.listen((event) {
        final dietSett = DietModel.fromMap(event.snapshot.value);
        setState(() {
          if (event.snapshot.value != null) {
            boarding = dietSett.onboarding!;
            e1 = int.parse(dietSett.etap1!);
            e2 = int.parse(dietSett.etap2!);
            e3 = int.parse(dietSett.etap3!);
            e4 = int.parse(dietSett.etap4!);
            startDate = parseToDate(dietSett.startDate!);
            count = countDays(startDate!, nowDate!);
            isLoaded = true;
          }
        });
      });
  }

  DateTime parseToDate(String date) {
    DateTime dateFormat = DateFormat('yyyy-MM-dd').parse(date);
    return dateFormat;
  }

  int countDays(DateTime date1, DateTime date2) {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }
   final difference = daysBetween(date1, date2);
   return difference;
  }

  etaps() {
    if (boarding == true){
      assert (count != null);
      if (count! <= (e1! - 1)) { 
        return NavigationEtap1Screen();
      } else if (count! < (e1! + e2!) && count! > (e1! - 1)) {
        return NavigationEtap2Screen();
      } else if (count! < (e1! + e2! + e3!) && count! > (e1! + e2! - 1)) {
        return NavigationEtap3Screen();
      } else if (count! < (e1! + e2! + e3! + e4!) && count! > (e1! + e2! + e3!- 1)) {
        return const Etap4();
      } else if (count! >= e1! + e2! + e3! + e4!) {
        return const Etap5();
      } else {
        return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
      }
    } else {
      return const Onbording();
    }
  }

   @override
  void deactivate() {
    _etapsStrem.cancel();
    super.deactivate();
  }
}