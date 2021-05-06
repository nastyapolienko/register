import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:register/jwt.dart';
import 'dart:async';
import 'dart:convert';

const ip = "192.168.18.97";


class User {
  final int uid;
  final String login;
  final String pass;
  final String name;
  final String role;

  User({this.uid, this.login, this.pass, this.name, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as int,
      login: json['login'] as String,
      pass: json['pass'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }
}

Future<User> fetchUser(int index, token) async {
  var a = index.toString();
  final response =
  await http.get('http://$ip:8080/users/' + a,
      headers: <String, String>{
        'Authorization' : 'Bearer $token',
      });

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load book');
  }
}

