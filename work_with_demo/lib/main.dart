import 'package:flutter/material.dart';
import 'package:work_with_demo/project_format/project_format_demo.dart';
import 'package:provider/provider.dart';

import 'UI/login_ui.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProjectModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogIn Demo',
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return const LogIn();
  }
}

