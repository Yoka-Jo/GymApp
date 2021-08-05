import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DateScreen extends StatefulWidget {
  static const routeName = '/DateScreen';

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  CalendarController _controller;
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  void initState() {
    _controller = CalendarController();
    super.initState();
  }

  Map<DateTime, List<dynamic>> days = {};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(children: [
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 90, left: 140),
            height: 210,
            width: double.infinity,
            color: Color(0xff232035),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 266,
            color: Color(0xff2D2940),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 20),
            child: Row(
              children: [
                Text(
                  'Log',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'History',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 310,
            height: 340,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xff2D2940),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(-1, 5))
                ]),
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection(user).doc('user').collection('events').snapshots(),
                builder: (context, snapShot) {

                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Text(
                      'Loading...',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ));
                  }

                  else {
                    try {
                      final data = snapShot.data.docs;
                      for (int i = 0; i < data.length; i++) {
                        days.putIfAbsent(
                            DateTime.parse(data[i]['data'].toDate().toString()),
                            () => [0]);
                      }
                      return TableCalendar(
                        holidays: days,
                        calendarController: _controller,
                        initialCalendarFormat: CalendarFormat.month,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          weekdayStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        builders: CalendarBuilders(
                            singleMarkerBuilder: (context, date, events) {
                          return FittedBox(
                            child: Container(
                                height: 10,
                                width: 9,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),


                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: .05,
                                          blurRadius: .05,
                                          offset: Offset(0, 2.5))
                                    ]),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 4.9),
                                )),
                          );
                        }, holidayDayBuilder: (context, date, events) {
                          return FittedBox(
                            child: Container(
                                height: 25,
                                width: 25,
                                margin: EdgeInsets.only(bottom: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: .05,
                                          blurRadius: .05,
                                          offset: Offset(0, 2.5))
                                    ]),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          );
                        }),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          highlightSelected: false,
                          selectedStyle: null,
                          highlightToday: false,
                          weekdayStyle: TextStyle(color: Colors.white),
                          outsideStyle: TextStyle(color: Colors.grey),
                          outsideWeekendStyle: TextStyle(color: Colors.grey),
                          weekendStyle: TextStyle(color: Colors.white),
                          outsideHolidayStyle: TextStyle(color: Colors.grey),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                    return Container();
                  }
                }),
          ),
        ],
      ),
    ]));
  }
}
