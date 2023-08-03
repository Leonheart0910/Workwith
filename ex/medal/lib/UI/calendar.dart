import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../DB/DBManager.dart';

class CalendarUI extends StatefulWidget {
  final DateTime data;
  final int id;
  const CalendarUI({super.key, required this.data, required this.id});

  @override
  State<CalendarUI> createState() => _CalendarUIState();
}

class _CalendarUIState extends State<CalendarUI> {
  List<dynamic>? initialAppointment;
  List<Meeting>? updatedAppointment;
  List<dynamic>? selectedAppointment;
  int agendaMode = 2; // 0 없는거, 1이면 있는거, 2 초기 화면

  @override
  void initState() {
    super.initState();
    getDataSource(widget.data, widget.id);
  }

  Future<void> getDataSource(DateTime between, int seletedId) async {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    // Use DBManager to get data
    List<Map<String, dynamic>> dataList = await DBManager().selectData();
    for (final data in dataList) {
      final int id = data['id'];

      final int sYear = data['start_year'] ?? today.year;
      final int sMon = data['start_mon'] ?? today.month;
      final int sDay = data['start_day'] ?? today.day;
      final int sTime = data['start_time'] ?? 9;
      final int sMin = data['start_min'] ?? 0;

      final int eYear = data['end_year'] ?? today.year;
      final int eMon = data['end_mon'] ?? today.month;
      final int eDay = data['end_day'] ?? today.day;
      final int eTime = data['end_time'] ?? 9;
      final int eMin = data['end_min'] ?? 0;

      final DateTime startTime = DateTime(sYear, sMon, sDay, sTime, sMin);
      final DateTime endTime = DateTime(eYear, eMon, eDay, eTime, eMin);
      final String title = data['title'];
      final String detail = data['detail'];
      final Color background = Color(int.parse(data['color'], radix: 16));

      if(id == seletedId) meetings.add(Meeting(id, title, detail, startTime, endTime, background, true));
      else meetings.add(Meeting(id, title, detail, startTime, endTime, background, false));
    }

    final List<Meeting> betweenMeetings = <Meeting>[];
    for(Meeting i in meetings){
      if(between == i.start || between == i.end || (between.isAfter(i.start) && between.isBefore(i.end))) {
        betweenMeetings.add(i);
      }
    }

    setState(() {
      updatedAppointment = meetings;
      initialAppointment = betweenMeetings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Row(
            children: [
              SizedBox(width:20 ),
              Container(
                height: 50,
                child: Text(
                  '달력',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(updatedAppointment),
              initialSelectedDate: widget.data,
              initialDisplayDate: widget.data,
              onTap: (CalendarTapDetails details) {
                print(details.targetElement.toString());
                if (details.targetElement == CalendarElement.calendarCell) {
                  if (details.appointments!.isEmpty){
                    setState(() { agendaMode = 0; });
                  }
                  else {
                    setState(() {
                      agendaMode = 1;
                      selectedAppointment = details.appointments;
                    });
                  }
                }
                else {
                  setState(() { agendaMode = 2; });
                }
              },
              monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
              // Add your other calendar settings here.
            ),
          ),

          if (agendaMode == 0)
            Container(
              height: MediaQuery.of(context).size.height * 0.28, // Or any other height you want.
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset('images/sun.png'),
                  Container(
                    color: Colors.white,
                    child: Text("일정이 없어요!!",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.07
                      ),
                    ),
                  )
                ],
              ),
            ),

          if (agendaMode == 1)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: ListView.builder(
                itemCount: selectedAppointment!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: selectedAppointment![index].background,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            // tileColor: selectedAppointment![index].background,
                            title: Text(selectedAppointment![index].title),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('yyyy. MM. dd ').format(selectedAppointment![index].start).toString()),
                                Text("~"),
                                Text(DateFormat('yyyy. MM. dd ').format(selectedAppointment![index].end).toString())
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedAppointment![index].isSelected = !selectedAppointment![index].isSelected;
                              });
                            }
                        ),
                        if(selectedAppointment![index].isSelected)
                          Column(
                            children: [
                              Divider(
                                  thickness: 0.7,
                                  color: Colors.grey[700]),
                              Container(
                                height: 100,
                                child: Center(child: Text(selectedAppointment![index].detail)),
                              ),
                            ],
                          )
                      ],
                    ),
                  );
                },
              ),
            ),

          if (agendaMode == 2)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: ListView.builder(
                itemCount: initialAppointment?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    color: initialAppointment![index].background,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            // tileColor: initialAppointment![index].background,
                            title: Text(initialAppointment![index].title),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('yyyy. MM. dd ').format(initialAppointment![index].start).toString()),
                                Text("~"),
                                Text(DateFormat('yyyy. MM. dd ').format(initialAppointment![index].end).toString())
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                initialAppointment![index].isSelected = !initialAppointment![index].isSelected;
                              });
                            }
                        ),
                        if(initialAppointment![index].isSelected)
                          Column(
                            children: [
                              Divider(
                                thickness: 0.7,
                                color: Colors.grey[700]),
                              Container(
                                height: 100,
                                child: Center(child: Text(initialAppointment![index].detail)),
                              ),
                            ],
                          )
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

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting>? source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).start;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).end;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).title;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isSelected(int index) {
    return _getMeetingData(index).isSelected;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.id, this.title, this.detail, this.start, this.end, this.background, this.isSelected);

  int id;

  /// Event name which is equivalent to subject property of [Appointment].
  String title;

  /// Event detail which is equivalent to subject property of [Appointment].
  String detail;

  /// From which is equivalent to start time property of [Appointment].
  DateTime start;

  /// To which is equivalent to end time property of [Appointment].
  DateTime end;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  bool isSelected;
}