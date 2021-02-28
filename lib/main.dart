import 'package:dawerha/screens/ForgotPassword.dart';
import 'package:dawerha/screens/HomeOwnerScreens/HomeOwnerCreateOrderScreen.dart';
import 'package:dawerha/screens/RegisterScreen.dart';
import 'package:dawerha/screens/introScreen.dart';
import 'package:dawerha/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dawerha/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // srart
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DAWERHA",
      home: IntroScreen(),
      routes: {
        "home": (context) {
          return Home();
        },
        "login": (context) {
          return Log();
        },
        "register": (context) {
          return RegisterScreen();
        },
        "reset": (context) {
          return ForgotPassword();
        },
        "create_order": (context) {
          return HomeOwnerCreateOrderScreen();
        }
      },
    ); //End
  }
}
