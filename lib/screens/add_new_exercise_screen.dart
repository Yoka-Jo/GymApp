import 'package:flutter/material.dart';
import 'package:test_app/shared/components/background_color.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/howManySets.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/saveButton.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/selectTypeOfExercise.dart';
import '../widgets/add_new_exercise_widgets/chooseMuscleGroup.dart';

class AddNewExerciseScreen extends StatelessWidget {
  static const routeName = '/AddNewWorkOut';

  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      onBackgroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: addNewExerciseAppBar(context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Divider(
                    color: Colors.white30,
                    endIndent: 25,
                    indent: 25,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  ChooseMuscleGroup(),
                  SizedBox(
                    height: 15.0,
                  ),
                  SelectTypeOfExerciseScreen(),
                  SizedBox(
                    height: 15.0,
                  ),
                  HowManySets(),
                  SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar addNewExerciseAppBar(BuildContext context) {
    return AppBar(
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
        title: RichText(
          text: TextSpan(
              text: "Add",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 23),
              children: [
                TextSpan(
                  text: "  New",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                ),
                TextSpan(
                  text: "  Exercise",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18),
                )
              ]),
        ));
  }
}
