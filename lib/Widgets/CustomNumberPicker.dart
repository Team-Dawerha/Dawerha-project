import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNumberPicker extends StatefulWidget {
  int index = 0;
  final Function onPlus;
  final Function onMinus;

  CustomNumberPicker({this.index, this.onPlus, this.onMinus});

  @override
  _CustomNumberPickerState createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.index++;
                  });
                  widget.onPlus(widget.index);
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                widget.index.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.index > 0) {
                    setState(() {
                      widget.index--;
                    });
                    widget.onMinus(widget.index);
                  }
                },
                child: Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
