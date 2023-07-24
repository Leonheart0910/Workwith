import 'package:flutter/material.dart';
import 'package:medal/UI/calendar.dart';
import 'UI/memos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UI(),
    );
  }
}

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _curIndex = index;
          });
        },

        currentIndex: _curIndex,  // 현재 탭
        selectedItemColor: Colors.blue, // 선택된 탭의 색
        unselectedItemColor: Colors.black54,  // 선택되지 않은 탭의 색
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task_outlined,
                size: 30,
                color: _curIndex == 0 ? Colors.blue : Colors.black54,
              ),
              label: "메모"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 30,
                color: _curIndex == 1 ? Colors.blue : Colors.black54,
              ),
              label: "달력"
          ),
        ],
      ),
    );
  }
  Widget getPage() {
    switch (_curIndex) {
      case 0 :
        return const MemosUI();
      default:
        return const CalendarUI();
    }
  }
}


