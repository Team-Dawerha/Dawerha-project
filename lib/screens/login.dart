import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Utils/SharedPrefManager.dart';
import 'package:dawerha/Utils/styles.dart';
import 'package:dawerha/Widgets/AppLogo.dart';
import 'package:dawerha/Widgets/LoginField.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:dawerha/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Log extends StatefulWidget {
  Log({Key key}) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول '),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppLogo(),
              SizedBox(height: 20.0),
              Text(
                'تسجيل الدخول',
                style: normalStyle,
              ),
              LoginField(
                keyboardType: TextInputType.emailAddress,
                hint: 'البريد الإلكتروني',
                onChange: (v) {
                  email = v;
                },
              ),
              LoginField(
                keyboardType: TextInputType.text,
                isPassword: true,
                hint: 'كلمة المرور',
                onChange: (v) {
                  password = v;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              NewButton(
                onPressed: () {
                  if (email.isEmpty) {
                    showToast(context, 'يجب عليك كتابة البريد الإلكتروني');
                    return;
                  }
                  if (password.isEmpty) {
                    showToast(context, 'يجب عليك كتابة كلمة المرور');
                    return;
                  }
                  login();
                },
                title: 'تسجيل الدخول',
              ),
              Text(
                'هل لديك حساب؟ إذا لم يكن لديك أنشئ حساب',
                style: textFieldTextStyle,
              ),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'تسجيل جديد',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'هل نسيت كلمة المرور؟ اضغط هنا لإعادة التعيين',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'reset');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    try {
      var _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_user != null) {
        print(_user.user.uid);
        _firestore.collection("HomeOwnerUser")
          ..where('id', isEqualTo: _user.user.uid)
              .snapshots()
              .listen((data) async {
            await setId(data.docs.first.data()["id"]);
            await setName(data.docs.first.data()["name"]);
            await setEmail(data.docs.first.data()["email"]);
          });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
        /*
        await _firestore
            .collection('HomeOwnerUser')
            .where("id", isEqualTo: _user.user.uid)
            .get()
            .then((value) {
          if (value.docs.length > 0) {
            value.docs.forEach((result) {
              setId(result.data()["id"]);
              setName(result.data()["name"]);
              setEmail(result.data()["email"]);
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            }));
          } else {
            showToast(context, 'لا يمكن العثور على المستخدم');
            return;
          }
        });
        **/
      } else {
        showToast(context, 'البريد الالكتروني أو كلمة المرور خاطئ');
      }
    } catch (e) {
      showToast(context, 'البريد الالكتروني أو كلمة المرور خاطئ');
    }
  }
}
