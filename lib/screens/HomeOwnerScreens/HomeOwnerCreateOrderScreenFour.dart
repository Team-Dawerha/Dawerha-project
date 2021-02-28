import 'package:dawerha/Utils/colors.dart';
import 'package:dawerha/Utils/styles.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:dawerha/screens/home.dart';
import 'package:flutter/material.dart';

class HomeOwnerCreateOrderScreenFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'طلب جديد',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'تم استلام طلبك بنجاح',
              style: logoStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            Image.asset(
              'assets/imges/check.png',
              color: Color(text_color),
              width: 50.0,
              height: 50.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'شكرا (*****) لتعاونك معنا',
              style: normalStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'سيتم تزويدكم بموعد الاستلام لاحقا',
              style: normalStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: NewButton(
                title: 'العودة إلى الواجهة الرئيسية',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Home();
                  }));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
