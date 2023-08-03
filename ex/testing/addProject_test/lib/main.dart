import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Data/data_format.dart';
import 'UI/main_ui.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataList(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing',
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {
    return const MainUI();
  }
}
