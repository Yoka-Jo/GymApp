import 'package:flutter/material.dart';
import 'package:test_app/shared/components/background.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/selectTypeOfExercise.dart';
import '../widgets/add_new_exercise_widgets/chooseMuscleGroup.dart';

class AddNewExerciseScreen extends StatelessWidget {
  static const routeName = '/AddNewWorkOut';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
      SliverFillRemaining(
        fillOverscroll: false,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 10.0,
            leading: IconButton(
              padding: EdgeInsets.only(left: 20.0),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white70,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Row(
              children: [
                Text(
                  'Add',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'New',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Exercise',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(children: [
              background(),
              Column(
                children: [
                  Divider(
                    color: Colors.white30,
                    endIndent: 25,
                    indent: 25,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: ChooseMuscleGroup(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 25, right: 25),
                child: SelectTypeOfExerciseScreen(),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
