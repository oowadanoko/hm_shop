import 'package:flutter/material.dart';

class ToastUtils {
  static bool _showLoading = false;
  static void showToast(BuildContext context, String msg) {
    if (_showLoading) {
      return;
    }
    _showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      _showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        width: 180,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
      ),
    );
  }
}
