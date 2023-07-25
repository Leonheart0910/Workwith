import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../DB/DBManager.dart';
import 'package:flutter/widgets.dart';

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData cancel_squared =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class MemosUI extends StatefulWidget {
  final Function(int, DateTime, int) onChangePage;

  const MemosUI({super.key, required this.onChangePage});

  @override
  State<MemosUI> createState() => _MemosUIState();
}

class _MemosUIState extends State<MemosUI> {
  List<Map<String, dynamic>> _dataList = [];
  late sendData result;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    List<Map<String, dynamic>> newDataList = await DBManager().selectData();
    setState(() {
      _dataList = newDataList; // 데이터 로드 후 화면을 갱신합니다.
    });
  }

  // 데이터 수정 메서드
  Future<void> _editData(
      int id,
      String title,
      String detail,
      String color,
      int sYear,
      int sMon,
      int sDay,
      int sTime,
      int sMin,
      int eYear,
      int eMon,
      int eDay,
      int eTime,
      int eMin) async {
    await DBManager().updateData(id, title, detail, color, sYear, sMon, sDay,
        sTime, sMin, eYear, eMon, eDay, eTime, eMin);
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
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.width * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '메모',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      result = (await showDialog<sendData>(
                        context: context,
                        builder: (_) {
                          return MyDialog();
                        },
                      ))!;

                      await DBManager().insertData(
                          result.title ?? "",
                          result.detail ?? "",
                          result.setColor,
                          result.startDate.year,
                          result.startDate.month,
                          result.startDate.day,
                          9,
                          0,
                          result.endDate.year,
                          result.endDate.month,
                          result.endDate.day,
                          23,
                          59);

                      // 데이터 삽입 후에는 loadData를 다시 호출하여 화면을 갱신합니다.
                      await loadData();


                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1.0)),
                ),
                child: Row(
                  children: [
                    Text(
                      '일정목록',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _dataList[index];

                    return Card(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onChangePage(
                                    1,
                                    DateTime(
                                        item['start_year'],
                                        item['start_mon'],
                                        item['start_day'],
                                        23,
                                        59,
                                        9),
                                    item['id']);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item['title']} "),
                                  // Text("Color : ${item['color']}"),
                                  Text(
                                      "${item['start_year']}/${item['start_mon']}/${item['start_day']}  ~ ${item['end_year']}/${item['end_mon']}/${item['end_day']}"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // 데이터 수정 다이얼로그 띄우기
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    final editTitleController =
                                        TextEditingController(
                                            text: item['title']);
                                    final editDetailController =
                                        TextEditingController(
                                            text: item['detail']);
                                    String editColor = item['color'];
                                    final editSYearController =
                                        TextEditingController(
                                            text:
                                                item['start_year'].toString());
                                    final editSMonthController =
                                        TextEditingController(
                                            text: item['start_mon'].toString());
                                    final editSDayController =
                                        TextEditingController(
                                            text: item['start_day'].toString());
                                    final editSTimeController =
                                        TextEditingController(
                                            text:
                                                item['start_time'].toString());
                                    final editSMinController =
                                        TextEditingController(
                                            text: item['start_min'].toString());
                                    final editEYearController =
                                        TextEditingController(
                                            text: item['end_year'].toString());
                                    final editEMonthController =
                                        TextEditingController(
                                            text: item['end_mon'].toString());
                                    final editEDayController =
                                        TextEditingController(
                                            text: item['end_day'].toString());
                                    final editETimeController =
                                        TextEditingController(
                                            text: item['end_time'].toString());
                                    final editEMinController =
                                        TextEditingController(
                                            text: item['end_min'].toString());

                                    return AlertDialog(
                                      title: const Text('수정하기'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              TextField(
                                                controller: editTitleController,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: '메모 제목 입력'),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller:
                                                    editDetailController,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: '메모 내용 입력'),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editSYearController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '시작 년도 입력'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editSMonthController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '시작 월 입력'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editSDayController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '시작 일 입력'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editEYearController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '마감 년도 입력'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editEMonthController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '마감 월 입력'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          editEDayController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  '마감 일 입력'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFFFAFB0';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFFFAFB0),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFF2CFA5';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFF2CFA5),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFFDFA87';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFFDFA87),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFAFFFBA';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFAFFFBA),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFAEE4FF';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFAEE4FF),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFB5CFED';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFB5CFED),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFCAA6FE';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFCAA6FE),
                                                        )),
                                                    const SizedBox(width: 5),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              CircleBorder(), // Set the button's shape
                                                        ),
                                                        onPressed: () {
                                                          editColor =
                                                              'FFDFD4E4';
                                                          print(editColor);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFDFD4E4),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ]),
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
                                            final editedTitle =
                                                editTitleController.text;
                                            final editedDetail =
                                                editDetailController.text;
                                            final String editedColor =
                                                editColor;
                                            final editedSYear = int.parse(
                                                editSYearController.text);
                                            final editedSMon = int.parse(
                                                editSMonthController.text);
                                            final editedSDay = int.parse(
                                                editSDayController.text);
                                            final editedSTime = int.parse(
                                                editSTimeController.text);
                                            final editedSMin = int.parse(
                                                editSMinController.text);
                                            final editedEYear = int.parse(
                                                editEYearController.text);
                                            final editedEMon = int.parse(
                                                editEMonthController.text);
                                            final editedEDay = int.parse(
                                                editEDayController.text);
                                            final editedETime = int.parse(
                                                editETimeController.text);
                                            final editedEMin = int.parse(
                                                editEMinController.text);

                                            await _editData(
                                                item['id'],
                                                editedTitle,
                                                editedDetail,
                                                editedColor,
                                                editedSYear,
                                                editedSMon,
                                                editedSDay,
                                                editedSTime,
                                                editedSMin,
                                                editedEYear,
                                                editedEMon,
                                                editedEDay,
                                                editedETime,
                                                editedEMin);
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String? title;
  String? detail;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(hours:24));

  String setColor = "FFFFAFB0";
  List<bool> selected = [true, false, false, false, false, false, false, false];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('추가하기'),
      content: Column(children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                hintText: '일정 제목 입력'),
          ),

          Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start date',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                Text(
                  DateFormat('yyyy. MM. dd')
                      .format(startDate ?? DateTime.now()),
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: MediaQuery.of(context).copyWith().size.height / 10,
            child: CupertinoDatePicker(
              initialDateTime: startDate,
              onDateTimeChanged: (DateTime newdate) {
                print(newdate);
                setState(() {
                  startDate = newdate;
                });
              },
              use24hFormat: true,
              maximumDate: new DateTime(2050, 12, 30),
              // minimumYear: 2010,
              // maximumYear: 2018,
              // minuteInterval: 1,
              mode: CupertinoDatePickerMode.date,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'End date',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                Text(
                  DateFormat('yyyy. MM. dd')
                      .format(endDate ?? DateTime.now()),
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: MediaQuery.of(context).copyWith().size.height / 10,
            child: CupertinoDatePicker(
              initialDateTime: endDate,
              onDateTimeChanged: (DateTime newdate) {
                print(newdate);
                setState(() {
                  endDate = newdate;
                });
              },
              use24hFormat: true,
              maximumDate: new DateTime(2050, 12, 30),
              // minimumYear: 2010,
              // maximumYear: 2018,
              // minuteInterval: 1,
              mode: CupertinoDatePickerMode.date,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          TextField(
            maxLines: 4,
            controller: detailController,
            decoration: const InputDecoration(
              hintText: '일정 세부내용 입력',
              border: OutlineInputBorder(),
              filled: true,),
          ),

          SizedBox(
            height: 10,
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:
                    CircleBorder(), // Set the button's shape
                  ),
                  onPressed: () {
                    setState(() {
                      selected[0] = true;
                      selected[1] = false;
                      selected[2] = false;
                      selected[3] = false;
                      selected[4] = false;
                      selected[5] = false;
                      selected[6] = false;
                      selected[7] = false;
                      setColor = 'FFFFAFB0';
                      print(setColor);
                    }); // Show text if not selected
                  },
                  child: CircleAvatar(
                    backgroundColor:
                    Color(0xFFFFAFB0),
                    child: selected[0]
                        ? Icon(Icons.check)  // Show check icon if selected
                        : Text(''),  // Show text if not selected
                  )
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = true;
                        selected[2] = false;
                        selected[3] = false;
                        selected[4] = false;
                        selected[5] = false;
                        selected[6] = false;
                        selected[7] = false;
                        setColor = 'FFF2CFA5';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFF2CFA5),
                      child: selected[1]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = true;
                        selected[3] = false;
                        selected[4] = false;
                        selected[5] = false;
                        selected[6] = false;
                        selected[7] = false;
                        setColor = 'FFFDFA87';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFFDFA87),
                      child: selected[2]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = false;
                        selected[3] = true;
                        selected[4] = false;
                        selected[5] = false;
                        selected[6] = false;
                        selected[7] = false;
                        setColor = 'FFAFFFBA';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFAFFFBA),
                      child: selected[3]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = false;
                        selected[3] = false;
                        selected[4] = true;
                        selected[5] = false;
                        selected[6] = false;
                        selected[7] = false;
                        setColor = 'FFAEE4FF';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFAEE4FF),
                      child: selected[4]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = false;
                        selected[3] = false;
                        selected[4] = false;
                        selected[5] = true;
                        selected[6] = false;
                        selected[7] = false;
                        setColor = 'FFB5CFED';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFB5CFED),
                      child: selected[5]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = false;
                        selected[3] = false;
                        selected[4] = false;
                        selected[5] = false;
                        selected[6] = true;
                        selected[7] = false;
                        setColor = 'FFCAA6FE';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFCAA6FE),
                      child: selected[6]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:
                      CircleBorder(), // Set the button's shape
                    ),
                    onPressed: () {
                      setState(() {
                        selected[0] = false;
                        selected[1] = false;
                        selected[2] = false;
                        selected[3] = false;
                        selected[4] = false;
                        selected[5] = false;
                        selected[6] = false;
                        selected[7] = true;
                        setColor = 'FFDFD4E4';
                        print(setColor);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Color(0xFFDFD4E4),
                      child: selected[7]
                          ? Icon(Icons.check)  // Show check icon if selected
                          : Text(''),
                    )),
              ],
            ),
          ),
        ]),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            title = titleController.text;
            detail = detailController.text;
            sendData result = sendData(title: title, detail: detail, setColor: setColor, startDate: startDate, endDate: endDate);
            Navigator.of(context).pop(result);
          },
          child: const Text('저장'),
        ),
      ]
    );
  }
}

class sendData{
  String? title;
  String? detail;
  String setColor;
  DateTime startDate;
  DateTime endDate;

  sendData({this.title, this.detail, required this.setColor, required this.startDate, required this.endDate});
}