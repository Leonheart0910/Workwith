import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> logIn(String id, String password, BuildContext context) async {
  const String loginAddress = 'http://10.0.2.2:8090'; // your login route
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    final response = await http.post(
      Uri.parse(loginAddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // SnackBar를 사용하여 메시지를 띄웁니다.
      final snackBar = SnackBar(
        content: Text('Login successful. ID: $id, Password: $password'),
        duration: const Duration(seconds: 5),
      );
      scaffoldMessenger.showSnackBar(snackBar);

      return true;  // Returns true if the status code is 200
    } else {
      // If server returns an error response, show error message.
      const snackBar = SnackBar(
        content: Text('Login Failed. 다시 시도해주세요.'),
        duration: Duration(seconds: 5),
      );
      scaffoldMessenger.showSnackBar(snackBar);

      return false;
    }
  } catch (e) {
    // If there is any error (like network failure), show a SnackBar
    const snackBar = SnackBar(
      content: Text('500 Error : 서버 응답 없음'),
      duration: Duration(seconds: 5),
    );
    scaffoldMessenger.showSnackBar(snackBar);

    return false;
  }
}