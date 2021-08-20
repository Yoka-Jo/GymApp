import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/shared/components/LineTitles.dart';
class ChartList extends StatefulWidget {
  final String name;

  ChartList(
     this.name,
  );

  @override
  _ChartListState createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  List<FlSpot> flSpot = [];
  final user = FirebaseAuth.instance.currentUser.uid;

  List<FlSpot> diagram(dynamic data) {
    flSpot = [];
    int m = 0;
    while (m < data.length) {
      if(data[m]['muscle'].split(' ').first == widget.name) {
        if(data[m]['pointTime'].toDouble() < 30 || data[m]['weight']>120){
        switch (data[m]['muscle']
            .split(' ')
            .first) {
          case 'Bicebs':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), 
                data[m]['weight'] 
                ));
            break;

          case 'Triceps':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'Chest':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'calves':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'hamstrings':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'quadriceps':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'trapezius':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          case 'forearms':
            flSpot.add(FlSpot(
                data[m]['pointTime'].toDouble(), data[m]['weight']));
            break;

          default:
            return [FlSpot(1, 2)];
        }
        }
      }
//      print(flSpot);
      m++;
    }
    return flSpot;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 250,
      width: 100,
      decoration: BoxDecoration(
          color: Color(0xff2D2940),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5))
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat.MMMM().format(DateTime.now()),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.white30,
            thickness: .7,
          ),
          SizedBox(height: 20.0,),
          Container(
            height: 160,
            width: 400,
//                                padding: EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      '       Max Weight(kgs)',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w300),
                    )),
                    SizedBox(width: 8.0,),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("usersExercises").doc(user).collection('diagramPoints')
                          .snapshots(),
                      builder: (ctx,  snapShot) {
                        if (snapShot.connectionState == ConnectionState.waiting) {
                          return Container();
                        }
                        else {
                          final data = snapShot.data.docs;
                          try {
                            return 
                            LineChart(
                                LineChartData(
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                titlesData: LineTitles.getTitleData(),
                                gridData: FlGridData(show: false),
                                backgroundColor: Color(0xff39364B),
                                minX: 1,
                                maxX: 29,
                                minY: 0,
                                maxY: 120,
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    dotData: FlDotData(show: diagram(data).isNotEmpty ? true:false),
                                    spots: 
                                      diagram(data).isNotEmpty ? diagram(data) : [FlSpot(0,-1.0)],
                                    colors: [
                                      Colors.blue,
                                      // Color(0xff46DFC9)
                                    ],
                                  ),
                                ]));
                          } catch (e) {
                            print(e);
                          }
                        }
                        return Container();
                      }),
                ),
              ],
            ),
          ),
          Text(
            'Time(week)',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
