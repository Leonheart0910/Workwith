import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data_format.dart';
import '../add_project/add_window.dart';

class MainUI extends StatefulWidget {
  const MainUI({super.key});

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft, // 텍스트를 왼쪽 정렬
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01), // 오른쪽 패딩을 비율로 조정
              child: const Text('Test'),
            ),
          ),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => showPopup(context),
              child: const Text('New Project'),
            ),
          ],
        ),
        body: Consumer<DataList> (
          builder: (context, data, child) {
            return Center(
              child: ListView.builder(
                itemCount: data.dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.dataList[index].title),
                    subtitle: Text(data.dataList[index].summary),
                  );
                },
              ),
            );
          },
        )
    );
  }
}