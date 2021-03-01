import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  Requests({Key key}) : super(key: key);

  @override
  _ReqState createState() => _ReqState();
}

class _ReqState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('  جدول الطلبات الجديدة   '),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
