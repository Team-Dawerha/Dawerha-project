import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Widgets/LoginField.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('إعادة تعيين كلمة المرور'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginField(
                keyboardType: TextInputType.emailAddress,
                hint: 'البريد الإلكتروني',
                onChange: (v) {
                  email = v;
                },
              ),
              SizedBox(height: 10.0),
              NewButton(
                title: 'إعادة تعيين',
                onPressed: () async {
                  if (email == "") {
                    showToast(context, 'يجب عليك كتابة البريد الإلكتروني');
                    return;
                  }
                  await sendPasswordResetEmail();
                  showToast(context, 'قم بتفحص بريدك الإلكتروني');
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future sendPasswordResetEmail() async {
    final _auth = FirebaseAuth.instance;
    return _auth.sendPasswordResetEmail(email: email);
  }
}
