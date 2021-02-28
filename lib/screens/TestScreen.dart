import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerha/Models/AddressObject.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(
          color: Colors.blue,
          child: Text('Click me'),
          onPressed: () async {
            var _firestore = FirebaseFirestore.instance.collection('Addresses');
            _firestore
              ..where("user_id", isEqualTo: "7uSfC9ivSyWmt7QmSKzcbiCSjKj2")
                  .snapshots()
                  .listen((data) {
                print(AddressObject.fromJson(data.docs.first.data()).lat);
              });
          },
        ),
      ),
    );
  }
}
