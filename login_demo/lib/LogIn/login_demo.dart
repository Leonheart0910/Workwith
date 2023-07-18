import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> login(String username, String password, BuildContext context) async {
  // SnackBar를 사용하여 메시지를 띄웁니다.
  final snackBar = SnackBar(
    content: Text('Username: $username, Password: $password'),
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  final response = await http.post(
    Uri.parse('https://your-server.com/login'), // your login route
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final token = jsonDecode(response.body)['token'];
    print('Login successful. Token: $token');
  } else {
    throw Exception('Failed to login.');
  }
}