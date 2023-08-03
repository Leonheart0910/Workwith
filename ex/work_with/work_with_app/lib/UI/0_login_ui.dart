import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:work_with_app/LogIn/login_demo.dart';
import 'package:work_with_app/UI/1_project_list_view_ui.dart';

class LogInUI extends StatefulWidget {
  const LogInUI({Key? key}) : super(key: key);

  @override
  _LogInUIState createState() => _LogInUIState();
}

class _LogInUIState extends State<LogInUI> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // LogIn_AppBar
      appBar: AppBar(title: const Text('Work With')),

      // LogIn_Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // LogIn_inputID
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'Enter your ID'),
            ),
            // LogIn_inputPassword
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Enter your password'),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // LogIn_SigninButton
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('회원가입')
                ),

                const SizedBox(width: 10),

                // LogIn_LoginButton
                ElevatedButton(
                  onPressed: () async {
                    String id = _idController.text;
                    String password = _passwordController.text;

                    bool logInSuccess = await logIn(id, password, context);

                    if (logInSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ProjectListView()),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}