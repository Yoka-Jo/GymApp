import 'package:flutter/material.dart';
import '../widgets/addNewExerciseButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewWorkOut extends StatelessWidget {
  static const routeName = '/newWorkOut';
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
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
            Column(
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
                        'Log',
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
                        'Workout',
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
            Padding(
              padding: const EdgeInsets.only(top: 110, left: 25, right: 25),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Work Out :',
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(user).doc('user').collection('newExercise')
                              .orderBy('id')
                              .snapshots(),
                          builder: (context, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Text(
                                'Loading...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ));
                            } else {
                              final data = snapShot.data.docs;

                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    height: 55,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xff2D2940),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Text(
                                                data.length > 0
                                                    ? data[data.length - 1]
                                                            ['id']
                                                        .split(' ')
                                                        .first
                                                    : '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    margin: EdgeInsets.only(top: 60),
                                    height: 200,
                                    width: 330,
                                    decoration: BoxDecoration(
                                        color: Color(0xff2D2940),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 10,
                                              blurRadius: 10)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Your Last Muscle Exercise',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Divider(
                                          color: Colors.white30,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            data.length > 0
                                                ? '- (Muscle) => ${data[data.length - 1]['muscle'].split(' ').first}'
                                                : '- (Muscle) =>',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            data.length > 0
                                                ? '- (Number of Sets) => ${data[data.length - 1]['setsNumber']}'
                                                : '- (Number of Sets) =>',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            data.length > 0
                                                ? '- (Max Weight) => ${data[data.length - 1]['specificWeight']}'
                                                : '- (Max Weight) =>',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            data.length > 0
                                                ? '- (Exercise Type) => ${data[data.length - 1]['exerciseType']}'
                                                : '- (Exercise Type) =>',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                          }),
                      SizedBox(
                        height: 40,
                      ),
                      AddNewExerciseButton()
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
