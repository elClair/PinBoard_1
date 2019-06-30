import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class NewPin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PinState();
  }
}

class PinState extends State<NewPin> {
  final TextEditingController _pinTitle = new TextEditingController();
  final TextEditingController _pinText = new TextEditingController();
  String _result = "";
  void _erase(){
    setState(() {
      _pinTitle.clear();
      _pinText.clear();
      _result="";
    });
  }
  void _mes(){
    setState(() {
      _result = "Wrong format file!";
    });
  }
  void _checkAdding(){
    setState(() {
      if(_pinTitle.text.isEmpty && _pinText.text.isEmpty){
       _result = "Empty!";
      } else if(!_pinTitle.text.startsWith(new RegExp('[A-Z][a-z]'))){
        _result = "Title must starts of letter or number";//Title is too long
      } else {
        database.reference().child("message").once().then((DataSnapshot snapshot){
          Map<dynamic, dynamic> list = snapshot.value;
        print("Values from b");
        });
        _result = "Pin was added";
        
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Pin Board"),
          centerTitle: true,
          backgroundColor: Colors.teal[800],
        ),
        backgroundColor: Colors.teal[100],

        body: new Container(

          child: new ListView(children: <Widget>[
            //form
            new Container(
                height: 160.0,
                width: 300.0,
                color: Colors.white,
                alignment: Alignment.topCenter,
                child: new Column(
                    children: <Widget>[
                  new TextField(
                controller: _pinTitle,
                cursorColor: Colors.brown,
                decoration: new InputDecoration(
                  hintText: 'Title',
                  icon: new Icon(Icons.title, color: Colors.brown),
                ),
              ),
                     new TextField(
                controller: _pinText,
                cursorColor: Colors.brown,
                decoration: new InputDecoration(
                    hintText: 'Text',
                    icon: new Icon(Icons.text_fields, color: Colors.brown),
                ),
              ),
            new Padding(padding: new EdgeInsets.all(5.5)),
                 new Center(
                     child: new Row(
                   children: <Widget>[
                    new Container(
                    margin: const EdgeInsets.only(left: 38.0),
                    child: new RaisedButton(
                    onPressed: _erase,
                    color: Colors.redAccent,
                    child: new Text("Clean",
                    style: new TextStyle(
                    color: Colors.white, fontSize: 16.9))),
                    ),
                     new Container(
                       margin: const EdgeInsets.only(left: 10.0),
                       child: new RaisedButton(
                           onPressed: _erase,
                           color: Colors.redAccent,
                           child: new Text("Add tags",
                               style: new TextStyle(
                                   color: Colors.white, fontSize: 16.9))),
                     ),
                    new Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: new RaisedButton(
                    onPressed: _checkAdding, //!!!
                    color: Colors.redAccent,
                    child: new Text("Add",
                    style: new TextStyle(
                    color: Colors.white, fontSize: 16.9))),
                    )
                    ],
                    ),
                    )
            ])),//form ends

            new Padding(padding: new EdgeInsets.all(5.5)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(" $_result !",
                  style: new TextStyle(color: Colors.white,
                      fontSize: 19.4,
                      fontWeight: FontWeight.w500),)
              ],

            )

          ]),
        ),
        floatingActionButton: new FloatingActionButton(
        onPressed: _mes,
    child: new Icon(Icons.add),
    ),
    );
  }
}
