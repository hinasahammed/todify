import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  void showFlushToast(BuildContext context, String title, String desc) {
    Flushbar(
      title: title,
      message: desc,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}