import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:system_biodairect/etaps_wrapper.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:system_biodairect/model/onboarding_content.dart';

class Onbording extends StatefulWidget {
  const Onbording({ Key? key }) : super(key: key);
  
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  bool cbDrops = false;
  late PageController _controller;
  List<bool> sexBtn = [true, false];
  String gender = '', sickness = '', age = '', height = '', startDiet = '';
  String? neck, chest, forearm, belt, hip, thigh;
  DateTime _startTime = DateTime.now();

  final _auth = FirebaseAuth.instance;

  final TextEditingController sickController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController neckController = TextEditingController();
  final TextEditingController chestController = TextEditingController();
  final TextEditingController forearmController = TextEditingController();
  final TextEditingController beltController = TextEditingController();
  final TextEditingController hipController = TextEditingController();
  final TextEditingController thighController = TextEditingController();

  final genderFocusNodes = [FocusNode(), FocusNode(), FocusNode()];

 @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //sick field
    final sickIssues = TextFormField(
      autofocus: false,
      controller: sickController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        sickController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.healing),
        contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 14),
        hintText: "Jeśli występują, wymień je tutaj",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //age field
    final ageField = TextFormField(
      autofocus: false,
      controller: ageController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        ageController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.hourglass_top_rounded),
        contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 14),
        labelText: 'Wiek: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //hight field
    final heightField = TextFormField(
      autofocus: false,
      controller: heightController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 14),
        labelText: 'Wzrost: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //neck field
    final neckField = TextFormField(
      autofocus: false,
      controller: neckController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Szyja: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //chest field
    final chestField = TextFormField(
      autofocus: false,
      controller: chestController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Klatka: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //forearm field
    final forearmField = TextFormField(
      autofocus: false,
      controller: forearmController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Przedramię: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //belt field
    final beltField = TextFormField(
      autofocus: false,
      controller: beltController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Pas: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //belt field
    final hipField = TextFormField(
      autofocus: false,
      controller: hipController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Biodra: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
    //belt field
    final thighField = TextFormField(
      autofocus: false,
      controller: thighController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 6),
        labelText: 'Udo: ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );

    String formatDate = DateFormat.yMMMd().format(_startTime);
    startDiet = DateFormat('yyyy-MM-dd').format(_startTime);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? _startdate = await showDatePicker(
        context: context, 
        initialDate: _startTime, 
        firstDate: DateTime(2020), 
        lastDate: DateTime(2040));
      if (_startdate != null) {
        setState(() {
          _startTime = _startdate;
        });
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              }, 
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Witamy w aplikacji Dieta hCG",
                        style: TextStyle(
                          fontSize: 24, 
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold
                        ),
                      ), 
                      SizedBox(height: 20),
                      Text(
                        "Dziękujemy za zaufanie i wybór naszej diety. Od dziś możesz zacząć swoją przygode z dietą hCG od Nabiotech Group. Powodzenia!",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.normal,        
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Zanim zaczniemy potrzebujemy paru informacji",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold, 
                        )
                      ), 
                      SizedBox(height: 18), 
                      Text(
                        "Problemy zdrowotne:",
                        style: TextStyle(
                          fontSize: 16, 
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.normal, 
                        ), 
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 16), 
                      sickIssues,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Moje dane:", 
                            style: TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold,
                              fontFamily: FitnessAppTheme.fontName,
                            ),
                          ), 
                          SizedBox(height: 20),
                          Text(
                            "Uzupełnij poniższe dane: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(height: 10), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ageField,
                                )
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: heightField,
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text("Jestem: ", 
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ToggleButtons(
                              isSelected: sexBtn,
                              borderRadius: BorderRadius.circular(30),
                              fillColor: Colors.green,
                              selectedColor: Colors.white,
                              renderBorder: false,
                              children: <Widget> [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    "Kobietą", 
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    "Meżczyzną", 
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal
                                    )
                                  ),
                                ),
                              ],
                              onPressed: (int newIndex) {
                                setState(() {
                                  for (int index = 0; index < sexBtn.length; index++){
                                    if (index ==newIndex) {
                                      sexBtn[index] = true;
                                    } else {
                                      sexBtn[index] = false;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Wybierz start diety: ", 
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                _selectDate(context);
                              }, 
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(formatDate.toString(), style: TextStyle(fontSize: 18),),
                            )),
                          ), 
                          SizedBox(height: 10),
                          Text(
                            "Pomiary ciała: ", 
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              SizedBox(
                                width: 100,
                                height: 300,
                                child: Image.asset("assets/fitness_app/men_body.png"),
                              ), 
                              Flexible(
                                child: Column(
                                  children: [
                                    neckField,
                                    SizedBox(height: 8), 
                                    chestField,
                                    SizedBox(height: 8), 
                                    forearmField,
                                    SizedBox(height: 8), 
                                    beltField,
                                    SizedBox(height: 8), 
                                    hipField,
                                    SizedBox(height: 8), 
                                    thighField
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 300,
                                child: Image.asset("assets/fitness_app/wmn_body.png"),
                              )
                            ]
                          )
                      ],),),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: TextButton(
              child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next"),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  postDetailsToFirestore();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EtapWrapper()),
                  );
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    User? user = _auth.currentUser;
    final uid = user!.uid;

    DatabaseReference ref = FirebaseDatabase.instance.ref('users/' + uid);

    
    if (sexBtn == [true, false]){gender = 'Woman';} else {gender = 'Men';}
    sickness = sickController.text;
    height = heightController.text;
    age = ageController.text;
    chest = chestController.text;
    neck = neckController.text;
    forearm = forearmController.text;
    belt = beltController.text;
    hip = hipController.text;
    thigh = thighController.text;
    
    await ref
      .update({
        'gender': gender,
        'sickness': sickness,
        'dietDate':{
          'etap1': '3', 
          'etap2': '2', 
          'etap3': '21', 
          'etap4': '21', 
          'startDate': startDiet,
          'onboarding': true,
        },
        'body': {
          'height': height,
          'age': age,
          'neck': neck,
          'chest': chest,
          'forearm': forearm,
          'belt': belt,
          'hip': hip,
          'thigh': thigh,
        }
      })
      .catchError((e) => Fluttertoast.showToast(msg: e!.message));
  }
}
