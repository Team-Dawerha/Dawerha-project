import 'package:flutter/material.dart';
import '../menu/MyDawerha.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("DAWERHA"),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.control_point), onPressed: () {})
          ],
        ),
        drawer: MyDrawer(), //End Drawer
        body: Column(),
      ),
    );
  }
}
