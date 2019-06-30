import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import './ModelPin.dart';
import './NewPinForm.dart';
import 'package:path/path.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class PinBoard extends StatelessWidget {
 

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
  List<ModelPin> boardMessages = List();
  ModelPin modelPin;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  @override
  void initState() {
    super.initState();

    modelPin = ModelPin("", "", "", "");
    databaseReference = database.reference().child("community");
    databaseReference.onChildAdded.listen(_onEntryAdded);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pin Board"),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
          actions: <Widget>[
      IconButton(
      icon: Icon(Icons.search),
      tooltip: 'Air it',
      onPressed: _mes,
    ),],
      ),
      body: Column(
        children: <Widget> [
//          Flexible(
//            flex: 0,
//            child: Form(
//              key: formKey,
//              child: Flex(direction: Axis.vertical,
//              children: <Widget>[
//                ListTile(
//                  leading: Icon(Icons.subject),
//                  title:TextFormField(
//                    initialValue: "",
//                    onSaved: (val) => modelPin.title = val,
//                    validator: (val) => val =="" ? val : null,
//                  ) ,
//                ),
//                ListTile(
//                  leading: Icon(Icons.message),
//                  title: TextFormField(
//                    initialValue: "",
//                    onSaved: (val) => modelPin.body = val,
//                    validator: (val) => val =="" ? val : null,
//                  ),
//                ),
//                //send or post
//              ],),
//
//            ),
//
//          ),
      Flexible(
      child: FirebaseAnimatedList(
      query: databaseReference,
      itemBuilder: (_, DataSnapshot snapshot,
          Animation<double> animation, int index)
      {
        return new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
           ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
            ),
            title: Text(boardMessages[index].title, style: new TextStyle(
                color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20)),
            subtitle: Text(boardMessages[index].body),

          ),
              new Container(
                height: 1.0,
                color: Colors.teal[800],
              ),

         new Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        ListTile(
      title:
      (boardMessages[index].pic!=null)?Image.network(boardMessages[index].pic):Image.asset('images/loginbutton.png',width: 0.0,height: 0.0 ),



          subtitle:   Text(boardMessages[index].tag), //boardMessages[index].pic:'images/loginbutton.png',
           // width: 80.0,
           // height: 80.0,
          ),
          // var image = await ImagePicker.pickImage(source: boardMessages[index].pic),
        ]))],),
        );},
    )),
        ],
        ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _mes,
        child: new Icon(Icons.add),
      ),
      );

  }
  void _mes(){
    runApp(new MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "hello app",
      home: new NewPinForm(),
    ));
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(ModelPin.fromSnapshot(event.snapshot));
    });
  }
}


