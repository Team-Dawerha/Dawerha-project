import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerha/Models/OrderItemObject.dart';
import 'package:dawerha/Utils/colors.dart';
import 'package:dawerha/Utils/styles.dart';
import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Widgets/LoginField.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'HomeOwnerCreateOrderScreenFour.dart';
import 'package:path/path.dart';

class HomeOwnerCreateOrderScreenThree extends StatefulWidget {
  double selectedLat;
  double selectedLng;
  String selectedAddressId;
  List<OrderItemObject> selectedItems;

  HomeOwnerCreateOrderScreenThree(
    this.selectedLat,
    this.selectedLng,
    this.selectedAddressId,
    this.selectedItems,
  );

  @override
  _HomeOwnerCreateOrderScreenThreeState createState() =>
      _HomeOwnerCreateOrderScreenThreeState();
}

class _HomeOwnerCreateOrderScreenThreeState
    extends State<HomeOwnerCreateOrderScreenThree> {
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int markersIndex = 1;
  var firebaseAuth;
  var firestore;
  var storage;
  String selectedDesc = '';

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
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.selectedLat, widget.selectedLng)),
                onMapCreated: onMapCreated,
                markers: Set<Marker>.of(markers.values),
                zoomControlsEnabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.searchLocation,
                        color: Color(text_color),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        'وصف الموقع',
                        style: smallStyle,
                      )
                    ],
                  ),
                  LoginField(
                    keyboardType: TextInputType.text,
                    hint: 'اكتب وصف الموقع هنا',
                    onChange: (v) {
                      selectedDesc = v;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: NewButton(
                      title: 'تأكيد العنوان',
                      onPressed: () {
                        if (selectedDesc == '') {
                          showToast(context, 'يجب عليك كتابة وصف الموقع');
                          return;
                        }
                        addOrder(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    goToPlace(widget.selectedLat, widget.selectedLng);
    addMarker(widget.selectedLat, widget.selectedLng);
  }

  void goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  void addMarker(double lat, double lng) {
    final MarkerId markerId = MarkerId(markersIndex.toString());

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: 'Hiii', snippet: '*'),
      onTap: () {},
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
    markersIndex++;
  }

  Future<void> addOrder(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    DateTime time = new DateTime(now.hour, now.minute, now.second);
    //Add order
    DocumentReference d1 = firestore.collection('Orders').doc();
    await firestore.collection('Orders').doc(d1.id).set({
      'id': d1.id,
      'user_id': firebaseAuth.currentUser.uid,
      'location_id': widget.selectedAddressId,
      'order_date': date.toString(),
      'order_time': time.toString(),
      'address': selectedDesc
    });

    //Add Items
    for (int i = 0; i < widget.selectedItems.length; i++) {
      OrderItemObject oio = widget.selectedItems[i];
      //Upload image to Storage
      String fileName = basename(oio.picture);
      try {
        await storage
            .ref('orders_images/$fileName')
            .putFile(File(oio.picture))
            .then((res) {
          res.ref.getDownloadURL().then((value) async {
            oio.picture = value;
            //widget.selectedItems[i] = oio;
            //Add order item
            DocumentReference d2 = firestore.collection('OrderItems').doc();
            await firestore.collection('OrderItems').doc(d2.id).set({
              'id': d2.id,
              'order_id': d1.id,
              'item_id': oio.item_id,
              'picture': oio.picture,
              'weight': oio.weight,
              'real_weight': oio.real_weight
            });
          });
        });
      } on FirebaseException catch (e) {
        print(e);
      }
      /*
      storage.child('orders_images/$fileName');
      UploadTask uploadTask = await storage.putFile(File(oio.picture));
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((value) {
          oio.picture = value;
          widget.selectedItems[i] = oio;
        });
      });
      **/

    }

    showToast(context, 'تم إضافة الطلب بنجاح');
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeOwnerCreateOrderScreenFour();
    }));
  }
}
