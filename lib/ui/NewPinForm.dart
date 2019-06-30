import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './ModelPin.dart';
import './PinBoard.dart';
//import './TextFieldAlertDialog.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class NewPinForm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pin Board',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String _result = "";
//  String _text = "initial";
  final TextEditingController _textFieldController = new TextEditingController();
 // Listener listen = Listener();
  var _tag;

//  TextEditingController _c;
  List<ModelPin> boardMessages = List();
  ModelPin modelPin;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  @override
  void initState() {
    super.initState();

    modelPin = ModelPin("", "", "", "");
    databaseReference = database.reference().child("community");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    //listen( if(_textFieldController.text!='')=>_tag = __textFieldController;
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pin Board"),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Column(
        children: <Widget> [
          Flexible(
            flex: 0,
            child: Form(
              key: formKey,
              child: Flex(direction: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.subject),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => modelPin.title = val,
                      validator: (val) => val == "" ? val : null,
                    ) ,
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => modelPin.body = val,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
//                  ListTile(
//                    leading: Icon(Icons.message),
//                    title: TextFormField(
//                      initialValue: "",
//                      onSaved: (_tag) => modelPin.tag = _tag,
//                      validator: (_textFieldController.text) => _textFieldController == "" ? _textFieldController : null,
//                    ),
//                  ),


                  //send or post

                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 30.0),
                  child :FlatButton(
                    child: Text("Clean", style: new TextStyle(
                        color: Colors.white, fontSize: 16.9)),

                    color: Colors.redAccent,
                    onPressed: (){
                    _mes;
                    },
    )),

                      new Container(
                          margin: const EdgeInsets.only(right: 30.0),
                          child :FlatButton(
                            child: Text("Add tags", style: new TextStyle(
                                color: Colors.white, fontSize: 16.9)),

                            color: Colors.redAccent,
                            onPressed: () => _displayDialog(context),
                          )),
          FlatButton(
          child: Text("Post",style: new TextStyle(
              color: Colors.white, fontSize: 16.9)),
      color: Colors.redAccent,
      onPressed: (){
        handleSubmit();
      },
    )])
  ],


                  )
                ),

            ),



        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _mes,
        child: new Icon(Icons.add),
      ),
    );

  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(ModelPin.fromSnapshot(event.snapshot));
    });
  }
  void handleSubmit() {
    final FormState form = formKey.currentState;
   // final FormState form2 = formKey2.currentState;
    if (form.validate()){
      form.save();
    //  form2.save();
      form.reset();
    //  form2.reset();
      databaseReference.push().set(modelPin.toJson());
      runApp(new MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "hello app",
        home: new PinBoard(),
      ));
    }
  }
  void _mes(){
    setState(() {
      _result = "Wrong format file!";
    });
  }

  _displayDialog(BuildContext context) async {
    @override
    void initState() {
      super.initState();

      modelPin = ModelPin("", "", "", "");

      databaseReference = database.reference().child("community");
      databaseReference.onChildAdded.listen(_onEntryAdded);
       _tag = _textFieldController.toString();
    // initialValue: _tag;
    // onSaved: (_tag) => modelPin.tag = _tag;
   // validator: (_tag) => _tag == "" ? _tag : null;
     // listen( if(_textFieldController.text!='')=>_tag = __textFieldController;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('Please add tags'),
            key: formKey2,
          title: TextFormField(
              //controller: _textFieldController,
            controller: _textFieldController,
           // if( _textFieldController!= '' ) => _tag =  _textFieldControllertext),
          ) ,
            actions: <Widget>[
              new FlatButton(
                child: new Text('Add'),
                onPressed: () {

                  Navigator.of(context).pop();
                  final FormState form = formKey.currentState;
                  final FormState form2 = formKey2.currentState;
                  if (form.validate()){
                    form.save();
                    form2.save();
                    form.reset();
                    form2.reset();
                    databaseReference.push().set(modelPin.toJson());
                    runApp(new MaterialApp(

                      debugShowCheckedModeBanner: false,
                      title: "hello app",
                      home: new PinBoard(),
                    ));
                  }
                },
              )
            ],
          );
        });
  }

}

