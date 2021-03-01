import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
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
              Navigator.of(context).pushNamed("home");
            },
          ),
          ListTile(
            title: Text(" تسجيل الدخول "),
            leading: Icon(Icons.login),
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
          ),
          ListTile(
            title: Text(" جدول الطلبات الجديدة "),
            leading: Icon(Icons.car_repair, color: Colors.green),
            onTap: () {
              Navigator.of(context).pushNamed("Requests");
            },
          ),
        ],
      ),
    );
  }
}
