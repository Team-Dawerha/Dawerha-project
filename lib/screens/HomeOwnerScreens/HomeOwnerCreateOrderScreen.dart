import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerha/Models/AddressObject.dart';
import 'package:dawerha/Utils/colors.dart';
import 'package:dawerha/Dialogs/ShowImageDialog.dart';
import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dawerha/Utils/SharedPrefManager.dart';
import 'package:dawerha/screens/HomeOwnerScreens/HomeOwnerCreateOrderScreenTwo.dart';

class HomeOwnerCreateOrderScreen extends StatefulWidget {
  @override
  _HomeOwnerCreateOrderScreenState createState() =>
      _HomeOwnerCreateOrderScreenState();
}

class _HomeOwnerCreateOrderScreenState
    extends State<HomeOwnerCreateOrderScreen> {
  double currentLat = 0.0;
  double currentLng = 0.0;
  double selectedLat = 0.0;
  double selectedLng = 0.0;
  String selectedAddressId = "";

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  int markersIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLat, currentLng)),
                      onMapCreated: onMapCreated,
                      markers: Set<Marker>.of(markers.values),
                      zoomControlsEnabled: false,
                      onTap: (point) {
                        if (markers.length > 0) {
                          setState(() {
                            markers.clear();
                          });
                          addMarker(point.latitude, point.longitude);
                          selectedLat = point.latitude;
                          selectedLng = point.longitude;
                        } else {
                          addMarker(point.latitude, point.longitude);
                          selectedLat = point.latitude;
                          selectedLng = point.longitude;
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: FloatingActionButton(
                        backgroundColor: Color(text_color),
                        child: Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          goToPlace(selectedLat, selectedLng);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  child: NewButton(
                    onPressed: () {
                      if (selectedLat == 0.0 || selectedLng == 0.0) {
                        showToast(context, 'يجب عليك اختيار موقع الطلب');
                        return;
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeOwnerCreateOrderScreenTwo(
                            selectedLat, selectedLng, selectedAddressId);
                      }));
                    },
                    title: 'طلب جديد',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    var _firebaseAuth = FirebaseAuth.instance;
    var _firestore = FirebaseFirestore.instance.collection("Addresses");
    String userId = _firebaseAuth.currentUser.uid;
    AddressObject address;
    _firestore
      ..where('user_id', isEqualTo: userId).snapshots().listen((data) {
        address = AddressObject.fromJson(data.docs.first.data());
        selectedLat = address.lat;
        selectedLng = address.lng;
        selectedAddressId = address.id;
        goToPlace(selectedLat, selectedLng);
        addMarker(selectedLat, selectedLng);
      });
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
}
