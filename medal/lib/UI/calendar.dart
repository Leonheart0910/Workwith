import 'package:flutter/material.dart';

class Calendar_UI extends StatefulWidget {
  const Calendar_UI({super.key});

  @override
  State<Calendar_UI> createState() => _Calendar_UIState();
}

class _Calendar_UIState extends State<Calendar_UI> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Align(
          alignment: Alignment.center,
          child: Text('달력 들어갈 부분'),
        ),
      ],
    );
  }
}
