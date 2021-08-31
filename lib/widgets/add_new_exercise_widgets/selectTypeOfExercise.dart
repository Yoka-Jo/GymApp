import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/exerciseTypeShape.dart';

class SelectTypeOfExerciseScreen extends StatefulWidget {
  @override
  _SelectTypeOfExerciseScreenState createState() => _SelectTypeOfExerciseScreenState();
}

class _SelectTypeOfExerciseScreenState extends State<SelectTypeOfExerciseScreen> {
  bool changeColor = false;
  TextStyle textStyle;
  bool delete;
  final textController = TextEditingController();

  Future<void> onSubmit(String value) async {
    if (value != null) {
      await FirebaseFirestore.instance
          .collection('exercisesType')
          .doc(value)
          .set({
        'title': value,
        'createdAt': Timestamp.now(),
      });
      textController.clear();
    } else {
      return;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select type of exercise',
          style:
              TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff2D2940),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('exercisesType')
                      .orderBy('createdAt', descending: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      print('waiting');
                      return Container(
                          height: 150,
                          child: Center(child: CircularProgressIndicator()));
                    }

                    else {
                      final data = snapShot.data.docs;
                      return SelectedTypeShape(data);
                      }
                  }
    ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 45,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xff39364B),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type in your own exercise',
                      hintStyle: TextStyle(color: Colors.white30),
                    ),
                    controller: textController,
                    onSubmitted: onSubmit,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
