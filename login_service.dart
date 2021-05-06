import 'package:http/http.dart';
import 'dart:convert';

import 'package:register/user_service.dart';

Future<String> loginUser(String login, String pass) async {
  String url = 'http://$ip:8080/login/';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"login": "'+login+'", "password": "'+pass+'"}';
  var response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;

  // final cookies = response.headers.map['set-cookie'];
  if (statusCode == 200){
    Map<String, dynamic> user = jsonDecode(response.body);
    return Future.value(user["token"]);
  } else {
    throw new Exception("Unauthorized");
  }
}
Future<String> getHash(String login, String pass) async {
  String url = 'http://$ip:8080/users/' + login;
  var response = await get(url);
  int statusCode = response.statusCode;
  if (statusCode == 200){
    Map<String, dynamic> user = jsonDecode(response.body);
    return Future.value(user["password"]);
  } else {
    throw new Exception("Hash mistake");
  }
}