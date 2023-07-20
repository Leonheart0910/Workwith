import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> login(String username, String password, BuildContext context) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    final response = await http.post(
      Uri.parse('http://localhost:8090/'), // your login route
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // SnackBar를 사용하여 메시지를 띄웁니다.
      final snackBar = SnackBar(
        content: Text('Login successful. Username: $username, Password: $password'),
        duration: const Duration(seconds: 5),
      );
      scaffoldMessenger.showSnackBar(snackBar);

      return true;  // Returns true if the status code is 200
    } else {
      return false;
    }
  } catch (e) {
    // If there is any error (like network failure), show a SnackBar
    const snackBar = SnackBar(
      content: Text('Login Fail.'),
      duration: Duration(seconds: 5),
    );
    scaffoldMessenger.showSnackBar(snackBar);
    return false;
  }
}