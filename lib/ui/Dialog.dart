import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Dialog {
  String title;
  information(BuildContext context, String title, String description) {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext){
    return AlertDialog(

    content: Text('dialogBody'),
    actions: <Widget>[
    FlatButton(
    child: Text('buttonText'),
    onPressed: () {
    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
    },
    ),
    ],
    );
    },
    );
  }
}