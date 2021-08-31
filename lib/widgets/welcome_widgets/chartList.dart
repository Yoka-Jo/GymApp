import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/exercise_model.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'package:test_app/shared/components/LineTitles.dart';

// ignore: must_be_immutable
class ChartList extends StatelessWidget {

  List<FlSpot> flSpot = [];

  List<FlSpot> diagram(List<ExerciseModel> data, String muscleName) {
    flSpot = [];
    int m = 0;
    while (m < data.length) {
      double pointTime = double.parse(data[m].pointTime);
      double weight = data[m].maxWeight;

      if (data[m].muscle.split(' ').first == muscleName) {
        if (pointTime < 30 || weight < 120) {
          switch (data[m].muscle.split(' ').first) {
            case 'Bicebs':
              addDiagramPoint(pointTime, weight);
              break;

            case 'Triceps':
              addDiagramPoint(pointTime, weight);
              break;

            case 'Chest':
              addDiagramPoint(pointTime, weight);
              break;

            case 'calves':
              addDiagramPoint(pointTime, weight);
              break;

            case 'hamstrings':
              addDiagramPoint(pointTime, weight);
              break;

            case 'quadriceps':
              addDiagramPoint(pointTime, weight);
              break;

            case 'trapezius':
              addDiagramPoint(pointTime, weight);
              break;

            case 'forearms':
              addDiagramPoint(pointTime, weight);
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

  void addDiagramPoint(double pointTime, double weight) {
    return flSpot.add(FlSpot(pointTime, weight));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context);
    final exercises = provider.exercises;
    return ListView(children: [
      diagramBody(provider, exercises, 'Bicebs'),
      diagramBody(provider, exercises, 'Triceps'),
      diagramBody(provider, exercises, 'Chest'),
      diagramBody(provider, exercises, 'calves'),
      diagramBody(provider, exercises, 'hamstrings'),
      diagramBody(provider, exercises, 'quadriceps'),
      diagramBody(provider, exercises, 'trapezius'),
      diagramBody(provider, exercises, 'forearms'),
    ]);
  }



  Container diagramBody(ProviderHelper provider,
      List<ExerciseModel> exercises, String muscleName) {
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
                muscleName,
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
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 160,
            width: 400,
//                                padding: EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (!provider.getExercisesLoading)
                      RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            '       Max Weight(kgs)',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w300),
                          )),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                provider.getExercisesLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : LineChart(LineChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: LineTitles.getTitleData(),
                        gridData: FlGridData(show: false),
                        backgroundColor: Color(0xff39364B),
                        minX: 1,
                        maxX: 31,
                        minY: 0,
                        maxY: 120,
                        lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              dotData: FlDotData(
                                  show:
                                      diagram(exercises, muscleName)
                                              .isNotEmpty
                                          ? true
                                          : false),
                              spots: diagram(exercises, muscleName)
                                      .isNotEmpty
                                  ? diagram(exercises, muscleName)
                                  : [FlSpot(0, 0)],
                              colors: [
                                Colors.blue,
                                // Color(0xff46DFC9)
                              ],
                            ),
                          ])),
              ],
            ),
          ),
          if (!provider.getExercisesLoading)
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
