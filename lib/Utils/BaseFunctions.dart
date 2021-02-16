import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showToast(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
}
