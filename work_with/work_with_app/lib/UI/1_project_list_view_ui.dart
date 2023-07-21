import 'package:flutter/material.dart';

class ProjectListView extends StatefulWidget {
  const ProjectListView({super.key});

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work With')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: _curIndex == 0 ? Colors.blue : Colors.black54,
              ),
              label: "진행중인 작업"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
                size: 30,
                color: _curIndex == 1 ? Colors.blue : Colors.black54,
              ),
              label: "완료된 작업"
          ),
        ],
      ),
    );
  }
}