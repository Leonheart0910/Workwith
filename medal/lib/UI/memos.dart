import 'package:flutter/material.dart';
import '../DB/DBManager.dart';

class Memos_UI extends StatefulWidget {
  const Memos_UI({super.key});

  @override
  State<Memos_UI> createState() => _Memos_UIState();
}

class _Memos_UIState extends State<Memos_UI> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _startMonthController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _endMonthController = TextEditingController();
  final TextEditingController _endDayController = TextEditingController();
  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    List<Map<String, dynamic>> newDataList = await DBManager().selectData();
    setState(() {
      _dataList = newDataList;  // 데이터 로드 후 화면을 갱신합니다.
    });
  }

  // 데이터 수정 메서드
  Future<void> _editData(int id, String title, String detail, int sYear, int sMon, int sDay, int eYear, int eMon, int eDay) async {
    await DBManager().updateData(id, title, detail, sYear, sMon, sDay, eYear, eMon, eDay);
    await loadData(); // 수정 후 데이터 재로드
  }

  // 데이터 삭제 메서드
  Future<void> _deleteData(int id) async {
    await DBManager().deleteData(id);
    await loadData(); // 삭제 후 데이터 재로드
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // 데이터 수정 다이얼로그 띄우기
                  showDialog(
                    context: context,
                    builder: (_) {
                      final TextEditingController titleController = TextEditingController();
                      final TextEditingController detailController = TextEditingController();
                      final TextEditingController startYearController = TextEditingController();
                      final TextEditingController startMonthController = TextEditingController();
                      final TextEditingController startDayController = TextEditingController();
                      final TextEditingController endYearController = TextEditingController();
                      final TextEditingController endMonthController = TextEditingController();
                      final TextEditingController endDayController = TextEditingController();

                      return AlertDialog(
                        title: const Text('데이터 수정'),
                        content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: titleController,
                                decoration: const InputDecoration(hintText: '메모 제목 입력'),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: detailController,
                                decoration: const InputDecoration(hintText: '메모 내용 입력'),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: startYearController,
                                      decoration: const InputDecoration(hintText: '시작 년도 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: startMonthController,
                                      decoration: const InputDecoration(hintText: '시작 월 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: startDayController,
                                      decoration: const InputDecoration(hintText: '시작 일 입력'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: endYearController,
                                      decoration: const InputDecoration(hintText: '마감 년도 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: endMonthController,
                                      decoration: const InputDecoration(hintText: '마감 월 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: endDayController,
                                      decoration: const InputDecoration(hintText: '마감 일 입력'),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final title = titleController.text;
                              final detail = detailController.text;
                              final sYear = int.parse(startYearController.text);
                              final sMon = int.parse(startMonthController.text);
                              final sDay = int.parse(startDayController.text);
                              final eYear = int.parse(endYearController.text);
                              final eMon = int.parse(endMonthController.text);
                              final eDay = int.parse(endDayController.text);

                              await DBManager().insertData(title, detail, sYear, sMon, sDay, eYear, eMon, eDay);

                              // 데이터 삽입 후에는 loadData를 다시 호출하여 화면을 갱신합니다.
                              await loadData();

                              Navigator.pop(context);
                            },
                            child: const Text('저장'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('메모 추가하기'),
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _dataList[index];

                return ListTile(
                  title: Text("${item['title']} : ${item['detail']}"),
                  subtitle: Text("${item['start_year']}/${item['start_mon']}/${item['start_day']} ~ ${item['end_year']}/${item['end_mon']}/${item['end_day']}"),
                  // 필요한 필드를 추가하여 더 많은 정보를 표시할 수 있습니다.
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // 데이터 수정 다이얼로그 띄우기
                          showDialog(
                            context: context,
                            builder: (_) {
                              final editTitleController = TextEditingController(text: item['title']);
                              final editDetailController = TextEditingController(text: item['detail']);
                              final editSYearController = TextEditingController(text: item['start_year'].toString());
                              final editSMonthController = TextEditingController(text: item['start_mon'].toString());
                              final editSDayController = TextEditingController(text: item['start_day'].toString());
                              final editEYearController = TextEditingController(text: item['end_year'].toString());
                              final editEMonthController = TextEditingController(text: item['end_mon'].toString());
                              final editEDayController = TextEditingController(text: item['end_day'].toString());

                              return AlertDialog(
                                title: const Text('데이터 수정'),
                                content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextField(
                                        controller: editTitleController,
                                        decoration: const InputDecoration(hintText: '메모 제목 입력'),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: editDetailController,
                                        decoration: const InputDecoration(hintText: '메모 내용 입력'),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              controller: editSYearController,
                                              decoration: const InputDecoration(hintText: '시작 년도 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editSMonthController,
                                              decoration: const InputDecoration(hintText: '시작 월 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editSDayController,
                                              decoration: const InputDecoration(hintText: '시작 일 입력'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              controller: editEYearController,
                                              decoration: const InputDecoration(hintText: '마감 년도 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editEMonthController,
                                              decoration: const InputDecoration(hintText: '마감 월 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editEDayController,
                                              decoration: const InputDecoration(hintText: '마감 일 입력'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final editedTitle = editTitleController.text;
                                      final editedDetail = editDetailController.text;
                                      final editedSYear = int.parse(editSYearController.text);
                                      final editedSMon = int.parse(editSMonthController.text);
                                      final editedSDay = int.parse(editSDayController.text);
                                      final editedEYear = int.parse(editEYearController.text);
                                      final editedEMon = int.parse(editEMonthController.text);
                                      final editedEDay = int.parse(editEDayController.text);

                                      await _editData(item['id'], editedTitle, editedDetail, editedSYear, editedSMon, editedSDay, editedEYear, editedEMon, editedEDay);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('저장'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // 데이터 삭제
                          _deleteData(item['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
