import 'package:flutter/material.dart';
import '../../screens/add_new_exercise_screen.dart';
import 'dart:ui' as ui;
class AddNewExerciseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(AddNewExerciseScreen.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff37779A), Color(0xff46DFC9)]),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Container(
          height: 58,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xff2D2940),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Add New Exercise',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 50,),
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff37779A), Color(0xff46DFC9)]),
                    shape: BoxShape.circle),
                height: 45,
                width: 45,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          Offset(10, 24.0),
                          Offset(28.0, 4.0),
                          [
                            Color(0xff37779A), Color(0xff46DFC9)
                          ],
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                      ),
                    ),
                    onPressed: () {},
                    backgroundColor: Color(0xff2D2940),
                  ),
                ),
              ),
                SizedBox(width: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
