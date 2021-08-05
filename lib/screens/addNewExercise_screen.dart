import 'package:flutter/material.dart';
import '../widgets/chooseMuscleGroup.dart';
import '../widgets/selectTypeofExercise.dart';
class AddNewWorkOut extends StatelessWidget {
  static const routeName = '/AddNewWorkOut';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 90, left: 140),
                  height: 210,
                  width: double.infinity,
                  color: Color(0xff232035),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 210,
                  color: Color(0xff2D2940),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    height: 90,
                    width: double.infinity,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 3),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white70,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
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
                  Divider(
                    color: Colors.white30,
                    endIndent: 25,
                    indent: 25,
                  ),
                ],
              ),
            ),
                  ChooseMuscleGroup(),
                  SelectTypeOfExercise(),
          ]),
        ),
      ),
    );
  }
}
