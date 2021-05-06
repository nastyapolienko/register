import 'dart:io';

import 'package:flutter/material.dart';
import 'package:register/first_screen.dart';
import 'package:register/user_service.dart';
import 'package:register/login_service.dart';
import 'package:register/jwt.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:crypto/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Журнал',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User> _futureUser;
  int a;
  List<User> b;
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  String _email = "";
  String _password = "";
  
  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Сторінка входу"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return new Container(
      height: 200,
      width: 350,
      child: new Column(
        children: <Widget>[
          // new Container(
          //   child: Image.asset('assets/images/logo.png'),
          // ),
          new Container(
            alignment: Alignment.topRight,
            child: new IconButton(
              icon: Icon(
                Icons.announcement_outlined,
                color: Colors.black38,
                size: 30.0,
              ),
              onPressed: (){
                //explanations 
              }
            ),
          ),
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  labelText: 'Логін'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              obscureText: _passwordVisible,
              controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Увійти'),
              onPressed: () => {
                setState(() {
                  getHash(_emailFilter.text, _passwordFilter.text).then((String hash){
                    //we get the hash from the database
                    //then we generate a hash from password from an app
                    //then we compare them
                    //if they are same then we can enter the if statement else -> an error
                    
                    print(md5.convert(utf8.encode(_passwordFilter.text)).toString());
                    print(hash);
                    if(md5.convert(utf8.encode(_passwordFilter.text)).toString() == hash){
                      loginUser(_emailFilter.text, hash).then((token) {
                        if(token == null){
                            start_flushbar(context);  
                        }
                        print(token);
                        print(getUserID(token));//по токену береться айді користувача
                        fetchUser(http.Client(), token).then((user){
                          var b = user.role;
                          print(b);
                          if(user.role == "tutor"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherPage(user, token)),
                            );
                          }
                          if(user.role == "user"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PupilPage(user, token)),
                            );
                          }                      
                        });  
                      });                      
                    }
                    else print("ЛОГІН АБО ПАРОЛЬ НЕ ВІРНІ");
                  });
                })
              },
            ),
          ],
        ),
      );
    
  }
  Future<User> fetchUser(http.Client client, String token) async {
    User user;
    final response =
    await client.get('http://$ip:8080/users/' + getUserID(token).toString(),
        headers: <String, String>{
          'Authorization' : 'Bearer $token'
        });
      if (response.statusCode == 200) {
        user = User.fromJson(json.decode(response.body));
        return user;
      } else {
        throw Exception('Failed to load a user');
      }
    }
}

Flushbar flush_1;//attention messages

   void start_flushbar(BuildContext context) {
    flush_1 = Flushbar<bool>(
      title: 'Невірний логін або пароль',
      message: 'Спробуйте ввести вірний логін та пароль, за допомогою якого входите в систему edu.edu',
      icon: Icon(
        Icons.info_outline,
        size: 20,
        color: Colors.blue.shade300,
      ),
      mainButton: FlatButton(
        onPressed: (){
          flush_1.dismiss(true);
        },
        child: Text("OK", style: TextStyle(color: Colors.amber),)
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 15),
    )..show(context);
  }//message that u cant login

  // void explanation(BuildContext (context)){
     
  //     new SimpleDialog(
  //         title: const Text('Select assignment'),
  //         children: <Widget>[
                  
  //         ],
  //     );
      
    
  // }

