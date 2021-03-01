import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyKau extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              " Hello somaya",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            accountEmail: Text(
              "so@gimal.com",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person), backgroundColor: Colors.grey),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text("الصفحة الرئيسية"),
            leading: Icon(Icons.home),
            onTap: () {
              print("tap");
            },
          ),
          ListTile(
            title: Text("الطلبات الجديدة"),
            leading: Icon(Icons.fiber_new),
            onTap: () {
              Navigator.of(context).pushNamed("new");
            },
          ),
          ListTile(
            title: Text(" جدول التوصيل "),
            leading: Icon(Icons.drive_eta_outlined),
            onTap: () {
              Navigator.of(context).pushNamed("delivery schedule");
            },
          ),
          
          ListTile(
            title: Text("إدارة المندوبين"),
            leading: Icon(Icons.contact_mail_rounded),
            onTap: () {
              print("tap");
            },
          ),
          
          ListTile(
            title: Text("إدارة الحاويات في الأحياء"),
            leading: Icon(Icons.restore_from_trash_rounded),
            onTap: () {
              print("tap");
            },
          ),
          ListTile(
            title: Text("إداره نقاط التحفيز "),
            leading: Icon(Icons.star_border_outlined),
            onTap: () {
              print("tap");
            },
          ),
        ],
      ),
    );
  }
}
