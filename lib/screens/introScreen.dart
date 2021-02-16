import 'package:dawerha/Widgets/button.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Image.asset('assets/imges/logo2.png'),
              SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OriginalButton(
                  text: 'البدء',
                  color: Colors.lightGreen[200],
                  textColor: Colors.lightGreenAccent[900],
                  onPressed: () {
                    Navigator.of(context).pushNamed('home');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
