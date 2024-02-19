import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void chatAppShowToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue.withOpacity(0.6),
      fontSize: 16);
}
