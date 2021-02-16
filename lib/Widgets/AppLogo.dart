import 'package:dawerha/Utils/styles.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/imges/logo_leave.png',
            width: 30.0,
            height: 30.0,
          ),
          Text(
            'Dwerha',
            style: logoStyle,
          )
        ],
      ),
    );
  }
}
