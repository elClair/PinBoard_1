import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PinItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;

  PinItem(this._itemName, this._dateCreated);

  PinItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
  }
  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;
    map["dateCreated"] = _dateCreated;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }
  PinItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_itemName,
          style: TextStyle(
              color: Colors.teal[700],
          fontWeight: FontWeight.bold,
          fontSize: 16.9
          ),),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text("Created on: $_dateCreated",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.5,
              fontStyle: FontStyle.italic
            ),),
          )
        ],
      ),
    );
  }

}