import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'package:test_app/shared/components/background_color.dart';

class DateScreen extends StatefulWidget {
  static const routeName = '/DateScreen';

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController();
    super.initState();
  }
  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }

  Map<DateTime, List<dynamic>> days = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context);
    final exercises = provider.exercises;
    return BackgroundColor(
      onBackgroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: ' Log',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23),
                ),
                TextSpan(
                  text: '  History',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                )
              ]),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Builder(
                    builder: (context) {        
                          final data = exercises;
                              for (int i = 0; i < data.length; i++) {
                                days.putIfAbsent(
                                    DateTime.parse(
                                        data[i].calendarDate.toString()),
                                    () => [0]);
                              }
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0 ),
                        // width: 310,
                        // height: 340,
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
                        child:TableCalendar(
                                    holidays: days,
                                    calendarController: _controller,
                                    initialCalendarFormat: CalendarFormat.month,
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekendStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                      weekdayStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)),
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                      outsideWeekendStyle:
                                          TextStyle(color: Colors.grey),
                                      weekendStyle: TextStyle(color: Colors.white),
                                      outsideHolidayStyle:
                                          TextStyle(color: Colors.grey),
                                    ),
                                  )
                              
                      );
                    }
                  ),
              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance
              //           .collection("usersExercises")
              //           .doc(uId)
              //           .collection('events')
              //           .snapshots(),
              //   builder: (context, snapshot) {
              //            if (snapshot.connectionState == ConnectionState.waiting) {
              //              return Expanded(
              //                child: Center(
              //                     child: CircularProgressIndicator()),
              //              );
              //            } else {
              //              try{
              //               return 
              //              }
              //              catch(e){
              //                print(e);
              //              }
              //              return Container();
              //            }
              //   }
              // ),
            ],
          )),
    );
  }
}
