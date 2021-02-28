import 'dart:async';

import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Utils/SharedPrefManager.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickLocationScreen extends StatefulWidget {
  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  double currentLat = 0.0;
  double currentLng = 0.0;
  double selectedLat = 0.0;
  double selectedLng = 0.0;

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  int markersIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(currentLat, currentLng)),
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
            width: double.infinity,
            height: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40.0,
                child: NewButton(
                  title: 'اختر موقعك',
                  onPressed: () {
                    if (markers.length == 0) {
                      showToast(context, 'يجب عليك اختيار موقعك على الخريطة');
                      return;
                    }
                    Navigator.pop(context, [selectedLat, selectedLng]);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    getCachedCoords().then((value) {
      setState(() {
        currentLat = value[0];
        currentLng = value[1];
        goToPlace(currentLat, currentLng);
      });
    });
  }

  Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() async {
        currentLat = position.latitude;
        currentLng = position.longitude;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setDouble('my_lat', currentLat);
        sharedPreferences.setDouble('my_lng', currentLng);
        goToPlace(currentLat, currentLng);
      });
    } catch (e) {
      print(e);
    }
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
