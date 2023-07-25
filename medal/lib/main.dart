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
    return MaterialApp(
      home: const UI(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  int _selectedAppointmentId = -1;
  int _currentPage = 0;
  DateTime _selectedAppointmentDay = DateTime.now();
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MemosUI(onChangePage: (index, info, id) => _changePage(index, info, id)),
      CalendarUI(data: _selectedAppointmentDay, id: _selectedAppointmentId),
    ];
  }


  void _changePage(int index, DateTime info, int id) {
    setState(() {
      _currentPage = index;
      _selectedAppointmentDay = info;
      _selectedAppointmentId = id;
      // Update _pages with the new info.
      _pages = [
        MemosUI(onChangePage: (index, info, id) => _changePage(index, info, id)),
        CalendarUI(data: _selectedAppointmentDay, id: _selectedAppointmentId),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,  // 현재 탭
        onTap: (index) => _changePage(index, DateTime.now(), -1),
        selectedItemColor: Colors.black, // 선택된 탭의 색
        unselectedItemColor: Colors.grey,   // 선택되지 않은 탭의 색
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                IconData(0xf030f, fontFamily: 'MaterialIcons'),
                size: 40,
                color: _currentPage == 0 ? Colors.black : Colors.grey,
              ),
              label: "메모"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                IconData(0xf06bb, fontFamily: 'MaterialIcons'),
                size: 40,
                color: _currentPage == 1 ?  Colors.black : Colors.grey,
              ),
              label: "달력"
          ),
        ],
      ),
    );
  }
// Widget getPage() {
//   switch (_curIndex) {
//     case 0 :
//       return const MemosUI();
//     default:
//       return const CalendarUI();
//   }
// }
}

