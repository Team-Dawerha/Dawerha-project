import 'package:dawerha/menu/MyDawerha.dart';
import 'package:dawerha/menu/MyKau.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dawerha/Widgets/button.dart';



class HomeScreenScientificKau extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeKauState();
  }
}

class HomeKauState extends State<HomeScreenScientificKau> {
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

        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(21.543333, 39.172779), zoom: 10),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OriginalButton(
                  text: ' جدول التوصيل ',
                  color: Colors.lightGreen[200],
                  textColor: Colors.lightGreenAccent[900],
                  onPressed: () {},
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}