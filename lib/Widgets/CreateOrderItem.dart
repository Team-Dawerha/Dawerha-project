import 'package:flutter/material.dart';

class CreateOrderItem extends StatelessWidget {
  final String title;
  final Function onRemove;

  CreateOrderItem({this.title, this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Material(
          elevation: 5.0,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                FlatButton(
                  color: Colors.red,
                  child: Text(
                    'حذف',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  onPressed: onRemove,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
