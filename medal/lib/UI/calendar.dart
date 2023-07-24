import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../DB/DBManager.dart';

class CalendarUI extends StatefulWidget {
  const CalendarUI({super.key});

  @override
  State<CalendarUI> createState() => _CalendarUIState();
}

class _CalendarUIState extends State<CalendarUI> {
  List<dynamic>? selectedAppointment;
  int agendaMode = 0; // 0 없는거, 1이면 있는거, 2면 목록을 누른거
  int selectedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(getDataSource()),
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
              height: 200, // Or any other height you want.
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Text('No Event!!'),
                  // Add other appointment details here.
                ],
              ),
            ),

          if (agendaMode == 1)
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: selectedTileIndex == -1 ? selectedAppointment!.length : selectedAppointment!.length+1,
                itemBuilder: (context, index) {
                  int realindex = index;
                  if(selectedTileIndex >= 0 && index > selectedTileIndex) realindex = index-1;

                  if (selectedTileIndex >= 0 && index == selectedTileIndex + 1) {
                    return Container(
                      height: 100,
                      color: Colors.green,
                      child: Center(child: Text(selectedAppointment![index-1].detail)),
                    );
                  }
                  return Card(
                    child: ListTile(
                        title: Text('${selectedAppointment![realindex].title}'),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Text(selectedAppointment![realindex].end.toString()),
                        ),
                        onTap: () {
                          setState(() {
                            selectedTileIndex = realindex;
                          });
                        }
                    ),
                  );
                },
              ),
            ),

          if (agendaMode == 2)
            Container(
              height: 200, // Or any other height you want.
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Text('Start: agenda Mode 2'),
                  // Add other appointment details here.
                ],
              ),
            ),


        ],
      ),
    );
  }
  Future<List<Meeting>> getDataSource() async {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    // Use DBManager to get data
    List<Map<String, dynamic>> dataList = await DBManager().selectData();
    for (final data in dataList) {
      final int sYear = data['sYear'] ?? today.year;
      final int sMon = data['sMon'] ?? today.month;
      final int sDay = data['sDay'] ?? today.day;
      final int sTime = data['sTime'] ?? 9;
      final int sMin = data['sMin'] ?? 0;
      final int eYear = data['eYear'] ?? today.year;
      final int eMon = data['eMon'] ?? today.month;
      final int eDay = data['eDay'] ?? today.day;
      final int eTime = data['eTime'] ?? 9;
      final int eMin = data['eMin'] ?? 0;

      print(data);
      final DateTime startTime = DateTime(sYear, sMon, sDay, sTime, sMin);
      final DateTime endTime = DateTime(eYear, eMon, eDay, eTime, eMin);
      final String title = data['title'];
      final String detail = data['detail'];
      final Color background = Color(int.parse(data['color'], radix: 16));

      meetings.add(Meeting(title, detail, startTime, endTime, background));
    }

    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(Future<List<Meeting>> source) {
    source.then((List<Meeting> meetings) {
      appointments = meetings;
    });
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
  Meeting(this.title, this.detail, this.start, this.end, this.background);

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
}
