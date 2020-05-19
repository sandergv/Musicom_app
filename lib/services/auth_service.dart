import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicomapp/models/user.dart';

class AuthService {

  static String _authUrl = "https://musicom.azurewebsites.net/api/v1/auth";
  static final headers = <String, String> {
  'Content-Type': 'application/json; charset=UTF-8'
  };
  static login(String email, String password) async {
    var response = await post(
        "$_authUrl/login",
        headers: headers,
        body: <String, String> {
          'email': email,
          'password': password
        });
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      await User(
          id: body['id'],
          email: body['email'],
          name: body['name'],
          token: body['token']
      ).saveData();
    }
  }

  static signup(String email, String name, String lastName, String password) async {
    var response = await post(
      "$_authUrl/signup",
      headers: headers,
      body: <String, String> {
        'email': email,
        'name': name,
        'lastName': lastName,
        'password': password
      }
    );
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      await User(
          id: body['id'],
          email: body['email'],
          name: body['name'],
          token: body['token']
      ).saveData();
    }
  }
}