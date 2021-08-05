import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/howManySets_screen.dart';
import '../widgets/saveButton.dart';
import '../screens/selectedType_screen.dart';

class SelectTypeOfExercise extends StatefulWidget {
  @override
  _SelectTypeOfExerciseState createState() => _SelectTypeOfExerciseState();
}

class _SelectTypeOfExerciseState extends State<SelectTypeOfExercise> {
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
    return Padding(
      padding: const EdgeInsets.only(top: 215, left: 25, right: 25),
      child: SingleChildScrollView(
        child: Column(
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
                      spreadRadius: 10)
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
                              child: Center(child: Text('Loading...' , style: TextStyle(color: Colors.white),),));
                        }

                        else {
                          print(snapShot.connectionState);
                          final data = snapShot.data.docs;
                          return SelectTypeScreen(data);
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
            SizedBox(
              height: 15,
            ),
            HowManySetsScreen(),
            SaveButton()
          ],
        ),
      ),
    );
  }
}
