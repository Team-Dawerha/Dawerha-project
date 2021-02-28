import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Utils/SharedPrefManager.dart';
import 'package:dawerha/Utils/colors.dart';
import 'package:dawerha/Utils/styles.dart';
import 'package:dawerha/Widgets/LoginField.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:dawerha/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PickLocationScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLocationSelected = false;
  double selectedLat = 0.0;
  double selectedLng = 0.0;
  String fullName = '';
  String firstPhoneNumber = '';
  String secondPhoneNumber = '';
  String email = '';
  String password = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('إنشاء حساب'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
          children: <Widget>[
            Text('إنشاء حساب', textAlign: TextAlign.center, style: logoStyle),
            SizedBox(
              height: 20.0,
            ),
            LoginField(
              hint: 'الاسم الكامل',
              onChange: (v) {
                fullName = v;
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginField(
              keyboardType: TextInputType.phone,
              hint: 'رقم الجوال الأول',
              onChange: (v) {
                firstPhoneNumber = v;
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginField(
              keyboardType: TextInputType.phone,
              hint: 'رقم الجوال الثاني',
              onChange: (v) {
                secondPhoneNumber = v;
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginField(
              keyboardType: TextInputType.emailAddress,
              hint: 'البريد الإلكتروني',
              onChange: (v) {
                email = v;
              },
            ),
            Text(
              'الموقع',
              style: textFieldTextStyle,
            ),
            Container(
              height: 40.0,
              child: FlatButton(
                child: Text(
                  isLocationSelected
                      ? 'تم اختيار الموقع'
                      : 'اختر موقعك على الخريطة',
                  style: isLocationSelected ? smallStyleWhite : smallStyle,
                ),
                color: isLocationSelected ? Color(text_color) : Colors.white,
                shape: OutlineInputBorder(
                  borderSide: isLocationSelected
                      ? BorderSide.none
                      : BorderSide(color: Color(text_color), width: 1.0),
                ),
                onPressed: () async {
                  try {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setDouble('my_lat', position.latitude);
                    sharedPreferences.setDouble('my_lng', position.longitude);
                    var data = Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PickLocationScreen();
                    }));
                    if (data != null) {
                      data.then((value) {
                        setState(() {
                          isLocationSelected = true;
                        });
                        selectedLat = value[0];
                        selectedLng = value[1];
                      });
                    }
                  } catch (e) {}
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginField(
              isPassword: true,
              hint: 'كلمة المرور',
              onChange: (v) {
                password = v;
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            NewButton(
              onPressed: () async {
                if (fullName == '') {
                  showToast(context, 'يجب عليك كتابة اسمك الكامل');
                  return;
                }
                if (firstPhoneNumber == '') {
                  showToast(context, 'يجب عليك كتابة رقم الجوال الأول');
                  return;
                }
                if (secondPhoneNumber == '') {
                  showToast(context, 'يجب عليك كتابة رقم الجوال الثاني');
                  return;
                }
                if (email == '') {
                  showToast(context, 'يجب عليك كتابة البريد الإلكتروني');
                  return;
                }
                if (!isLocationSelected) {
                  showToast(context, 'يجب اختيار موقعك على الخريطة');
                  return;
                }
                register();
              },
              title: 'إنشاء الحساب',
            ),
            Visibility(
              visible: isLoading ? true : false,
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void register() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        await _firestore.collection('HomeOwnerUser').add({
          'id': newUser.user.uid,
          'name': fullName,
          'phone1': firstPhoneNumber,
          'phone2': secondPhoneNumber,
          'email': email
        });
        DocumentReference d1 = _firestore.collection('Addresses').doc();
        await _firestore.collection('Addresses').doc(d1.id).set({
          'id': d1.id,
          'lat': selectedLat,
          'lng': selectedLng,
          'user_id': newUser.user.uid
        });
        /*
        await _firestore.collection('Users').add({
          'id': newUser.user.uid,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'email': email,
          'password': password,
          'lat': selectedLat,
          'lng': selectedLng
        });
        **/
        showToast(context, 'تم إنشاء الحساب بنجاح');
        setId(newUser.user.uid);
        setName(fullName);
        setEmail(email);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        showToast(context, 'الرجاء التأكد من البيانات');
      }
    } catch (e) {
      showToast(context, 'الرجاء التأكد من البيانات');
    }
  }
}
