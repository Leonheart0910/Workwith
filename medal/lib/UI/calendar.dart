import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar_UI extends StatefulWidget {
  const Calendar_UI({super.key});

  @override
  State<Calendar_UI> createState() => _Calendar_UIState();
}

class _Calendar_UIState extends State<Calendar_UI> {
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
              dataSource: MeetingDataSource(_getDataSource()),
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
                      child: Center(child: Text(selectedAppointment![index-1].eventName)),
                    );
                  }
                  return Card(
                    child: ListTile(
                        title: Text(selectedAppointment![realindex].eventName),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Text(selectedAppointment![realindex].to.toString()),
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
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: -40));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Conference2', startTime, endTime, const Color(0xFF0F0544), false));
    meetings.add(Meeting(
        'Conference3', startTime, endTime, const Color(0xFF434314), false));
    meetings.add(Meeting(
        'Conference4', startTime, endTime, const Color(0xFF004300), false));
    meetings.add(Meeting(
        'Conference2', startTime, endTime, const Color(0xFF0F0544), false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
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
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
