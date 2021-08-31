import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'chartList.dart';

class MusclesDiagramList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context);
    final exercises = provider.exercises;
    return Expanded(
      child:provider.getExercisesLoading ? Center(child: CircularProgressIndicator(),) :   Column(
        children: [
          exercises.isEmpty
              ? Column(
                  children: [
                    Text(
                      "Let's Do Some WorkOut Now",
                      style: TextStyle(color: Colors.white70, fontSize: 25.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    )
                  ],
                )
              : Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 35.0,
                        maxHeight: 138.0,
                      ),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: exercises.length,
                        separatorBuilder: (context, i) => SizedBox(
                          width: 15.0,
                        ),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              color: Color(0xff2D2940),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(-1, 5))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/dum.png',
                                    fit: BoxFit.cover,
                                    height: 55,
                                  ),
                                  Text(
                                    exercises[index].muscle.split(' ').first,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    exercises[index].exerciseType.split(' ').first,
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                    color: Color(0xff2D2940),
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Colors.blue,
                                    ),
                                    onSelected: (value) {
                                      provider
                                          .deleteExercise(exercises[index].id);
                                    },
                                    itemBuilder: (_) => [
                                          PopupMenuItem(
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: 0,
                                          )
                                        ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
              ),
                  Expanded(child: ChartList()),

        ],
      ),
    );
  }
}
