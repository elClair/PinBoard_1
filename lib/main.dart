import 'package:flutter/material.dart';
//import './ui/welcome_home.dart';
import 'package:firebase_database/firebase_database.dart';
//import './ui/NewPin.dart';
import './ui/PinBoard.dart';
import './ui/NewPinForm.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
void main() {
  runApp(new MaterialApp(

    debugShowCheckedModeBanner: false,
    title: "hello app",
    home: new PinBoard(),
  ));
}

