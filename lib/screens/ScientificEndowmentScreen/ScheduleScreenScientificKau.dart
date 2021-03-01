import 'package:dawerha/menu/MyKau.dart';
import 'package:flutter/material.dart';

class ScheduleScreenScientificKau extends StatefulWidget {
  State<StatefulWidget> createState() {
    return ScheduleState();
  }
}

class ScheduleState extends State<ScheduleScreenScientificKau> {
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
        drawer: MyKau(), //End Drawer

        body: Column(
         
        ),
      ),
    );
  }
  }