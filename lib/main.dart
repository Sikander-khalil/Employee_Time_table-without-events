
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

   DateTime selectedDay;
   List <CleanCalendarEvent> selectedEvent;

  final Map<DateTime,List<CleanCalendarEvent>> events = {
    DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day+2):
    [
      CleanCalendarEvent('Duty no 1',
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: 'A special duty',
         isAllDay: true,

          color: Colors.blue),
    ],

    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1):
    [
      CleanCalendarEvent('Duty no 2',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1, 8, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),

          color: Colors.orange),
      ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3):
    [
      CleanCalendarEvent('Duty no 3',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 3, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.yellow),
    ],
  };

  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }
  @override
  void initState() {
    // TODO: implement initState

    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
      ),


        body: SafeArea(


            child: Container(

              child: Calendar(

                startOnMonday: true,
                selectedColor: Colors.blue,
                todayColor: Colors.red,
                eventColor: Colors.green,
                eventDoneColor: Colors.amber,
                bottomBarColor: Colors.deepOrange,
                onRangeSelected: (range) {
                  print('selected Day ${range.from},${range.to}');
                },
                onDateSelected: (date){
                  return _handleData(date);
                },
                events: events,
                isExpanded: true,

                dayOfWeekStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                bottomBarTextStyle: TextStyle(
                  color: Colors.white,
                ),
                hideBottomBar: false,
                hideArrows: false,
                weekDays: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
              ),
            ),

        ),

    );
  }

}
