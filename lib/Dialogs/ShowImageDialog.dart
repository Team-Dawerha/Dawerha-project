import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImageDialog extends StatefulWidget {
  @override
  _ShowImageDialogState createState() => _ShowImageDialogState();
  String url;
  ShowImageDialog(this.url);
}

class _ShowImageDialogState extends State<ShowImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          imageProvider: NetworkImage(widget.url),
        ),
      ),
    );
  }
}
