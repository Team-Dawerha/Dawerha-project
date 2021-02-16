import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final title;
  final onPressed;

  NewButton({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      child: FlatButton(
        color: Colors.lightGreen[200],
        child: Text(
          title,
          style: TextStyle(
              color: Colors.lightGreenAccent[900],
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide.none),
        onPressed: onPressed,
      ),
    );
  }
}
