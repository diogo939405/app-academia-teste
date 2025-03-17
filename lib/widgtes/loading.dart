import 'package:flutter/material.dart';

void loading(BuildContext context, bool isLoading) {
  if (isLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  } else {
    Navigator.of(context).pop();
  }
}
