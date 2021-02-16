import 'package:dawerha/Utils/styles.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final keyboardType;
  final isPassword;
  final hint;
  final Function onChange;

  LoginField(
      {this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.hint,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      style: textFieldTextStyle,
      decoration: InputDecoration(
        hintText: hint,
        labelText: hint,
        labelStyle: smallStyle,
      ),
      onChanged: onChange,
    );
  }
}
