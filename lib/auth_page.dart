import 'package:flutter/material.dart';
import 'package:system_biodairect/login_screen.dart';
import 'package:system_biodairect/registration_screen.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? LoginScreen(onClickedSignUp: toogle)
    : RegistrationScreen(onClickedSignIn: toogle);

    void toogle() => setState(() => isLogin = !isLogin);
}