import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _welcomeString= "";

  void _erase(){
    setState(() {
      _userController.clear();
      _passwordController.clear();
    });
  }
  void _showWelcome(){
    setState(() {
      if(_userController.text.isNotEmpty && _passwordController.text.isNotEmpty){
        _welcomeString=_userController.text;
      } else _welcomeString = "Nothing";
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
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              'images/loginbutton.png',
              width: 80.0,
              height: 80.0,
            ),
            //form
            new Container(
              height: 180.0,
              width: 380.0,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _userController,
                    cursorColor: Colors.brown,
                    decoration: new InputDecoration(
                      hintText: 'UserName',
                      icon: new Icon(Icons.person, color: Colors.brown),
                    ),
                  ),
                  new TextField(
                    controller: _passwordController,
                    cursorColor: Colors.brown,
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(Icons.lock, color: Colors.brown)),
                    obscureText: true,
                  ),
                  new Padding(padding: new EdgeInsets.all(10.5)),
                  new Center(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(left: 38.0),
                          child: new RaisedButton(
                              onPressed: _showWelcome,
                              color: Colors.redAccent,
                              child: new Text("Login",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16.9))),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(left: 160.0),
                          child: new RaisedButton(
                              onPressed: _erase,
                              color: Colors.redAccent,
                              child: new Text("Clean",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16.9))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),//form ends
            new Padding(padding: new EdgeInsets.all(10.5)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Welcome $_welcomeString !",
                style: new TextStyle(color: Colors.white,
                fontSize: 19.4,
                fontWeight: FontWeight.w500),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
