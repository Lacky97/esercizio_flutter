  import 'package:flutter/material.dart';

  
  void _snackBar(BuildContext context, String message) {
    final snakBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakBar);
  }