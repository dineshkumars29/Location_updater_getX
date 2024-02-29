import 'package:flutter/material.dart';

class Commonwidget {
  static message(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
