import 'package:flutter/material.dart';
import '../DB/DBManager.dart';

class MemosUI extends StatefulWidget {
  const MemosUI({super.key});

  @override
  State<MemosUI> createState() => _MemosUIState();
}

class _MemosUIState extends State<MemosUI> {
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
  Future<void> _editData(
      int id, String title, String detail, String color, int sYear, int sMon, int sDay, int sTime, int sMin, int eYear, int eMon, int eDay, int eTime, int eMin
      ) async {
    await DBManager().updateData(id, title, detail, color, sYear, sMon, sDay, sTime, sMin, eYear, eMon, eDay, eTime, eMin);
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
                      final TextEditingController startTimeController = TextEditingController();
                      final TextEditingController startMinController = TextEditingController();
                      final TextEditingController endYearController = TextEditingController();
                      final TextEditingController endMonthController = TextEditingController();
                      final TextEditingController endDayController = TextEditingController();
                      final TextEditingController endTimeController = TextEditingController();
                      final TextEditingController endMinController = TextEditingController();
                      String setColor = '0xFF0F8644';

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
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: startTimeController,
                                      decoration: const InputDecoration(hintText: '시작 시간 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: startMinController,
                                      decoration: const InputDecoration(hintText: '시작 분 입력'),
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
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: endTimeController,
                                      decoration: const InputDecoration(hintText: '마감 시간 입력'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: endMinController,
                                      decoration: const InputDecoration(hintText: '마감 분 입력'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                      onPressed: () {
                                        setColor = 'FF0F8644';
                                        print(setColor);
                                      },
                                      child: Text('Color 1'),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      setColor = 'FF0F0544';
                                      print(setColor);
                                    },
                                    child: Text('Color 2'),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      setColor = 'FF434314';
                                      print(setColor);
                                    },
                                    child: Text('Color 3'),
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
                              final String color = setColor;
                              final sYear = int.parse(startYearController.text);
                              final sMon = int.parse(startMonthController.text);
                              final sDay = int.parse(startDayController.text);
                              final sTime = int.parse(startTimeController.text);
                              final sMin = int.parse(startMinController.text);
                              final eYear = int.parse(endYearController.text);
                              final eMon = int.parse(endMonthController.text);
                              final eDay = int.parse(endDayController.text);
                              final eTime = int.parse(endTimeController.text);
                              final eMin = int.parse(endMinController.text);

                              await DBManager().insertData(title, detail, color, sYear, sMon, sDay, sTime, sMin, eYear, eMon, eDay, eTime, eMin);

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

                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${item['title']} : ${item['detail']}"),
                          Text("Color : ${item['color']}"),
                          Text("${item['start_year']}/${item['start_mon']}/${item['start_day']} ${item['start_time']}:${item['start_min']} ~ ${item['end_year']}/${item['end_mon']}/${item['end_day']} ${item['end_time']}:${item['end_min']}"),
                        ],
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // 데이터 수정 다이얼로그 띄우기
                          showDialog(
                            context: context,
                            builder: (_) {
                              final editTitleController = TextEditingController(text: item['title']);
                              final editDetailController = TextEditingController(text: item['detail']);
                              String editColor = item['color'];
                              final editSYearController = TextEditingController(text: item['start_year'].toString());
                              final editSMonthController = TextEditingController(text: item['start_mon'].toString());
                              final editSDayController = TextEditingController(text: item['start_day'].toString());
                              final editSTimeController = TextEditingController(text: item['start_time'].toString());
                              final editSMinController = TextEditingController(text: item['start_min'].toString());
                              final editEYearController = TextEditingController(text: item['end_year'].toString());
                              final editEMonthController = TextEditingController(text: item['end_mon'].toString());
                              final editEDayController = TextEditingController(text: item['end_day'].toString());
                              final editETimeController = TextEditingController(text: item['end_time'].toString());
                              final editEMinController = TextEditingController(text: item['end_min'].toString());

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
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: editSTimeController,
                                              decoration: const InputDecoration(hintText: '시작 시간 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editSMinController,
                                              decoration: const InputDecoration(hintText: '시작 분 입력'),
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
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: editETimeController,
                                              decoration: const InputDecoration(hintText: '마감 시간 입력'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: editEMinController,
                                              decoration: const InputDecoration(hintText: '마감 분 입력'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              editColor = 'FF0F8644';
                                            },
                                            child: Text('Color 1'),
                                          ),
                                          const SizedBox(width: 10),
                                          OutlinedButton(
                                            onPressed: () {
                                              editColor = 'FF0F0544';
                                            },
                                            child: Text('Color 2'),
                                          ),
                                          const SizedBox(width: 10),
                                          OutlinedButton(
                                            onPressed: () {
                                              editColor = 'FF434314';
                                            },
                                            child: Text('Color 3'),
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
                                      final String editedColor = editColor;
                                      final editedSYear = int.parse(editSYearController.text);
                                      final editedSMon = int.parse(editSMonthController.text);
                                      final editedSDay = int.parse(editSDayController.text);
                                      final editedSTime = int.parse(editSTimeController.text);
                                      final editedSMin = int.parse(editSMinController.text);
                                      final editedEYear = int.parse(editEYearController.text);
                                      final editedEMon = int.parse(editEMonthController.text);
                                      final editedEDay = int.parse(editEDayController.text);
                                      final editedETime = int.parse(editETimeController.text);
                                      final editedEMin = int.parse(editEMinController.text);

                                      await _editData(
                                          item['id'], editedTitle, editedDetail, editedColor, editedSYear, editedSMon, editedSDay, editedSTime, editedSMin, editedEYear, editedEMon, editedEDay, editedETime, editedEMin
                                      );
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