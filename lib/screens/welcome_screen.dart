import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/musclesList.dart';
import '../screens/userInfo_screen.dart';
class WelcomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 90, left: 140),
                  height: 210,
                  width: double.infinity,
                  color: Color(0xff232035),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 266,
                  color: Color(0xff2D2940),
                ),
              ],
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                          'WELCOME,',
                          style: TextStyle(
                              color: Colors
                                  .white,
                              fontWeight: FontWeight
                                  .w300,
                              fontSize: 30),
                        ),
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('emails').doc(user)
                              .get(),
                          builder: (context, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('...');
                            }
                            try {
                              if (snapShot.connectionState ==
                                  ConnectionState.done) {
                                final data = snapShot.data.data();
                                return Text(
                                  data['userName']
                                      .split(' ')
                                      .first,
                                  style: TextStyle(
                                      color: Colors
                                          .white,
                                      fontWeight: FontWeight
                                          .bold,
                                      fontSize: 30),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              print(e);
                            }
                            return Container();
                          },

                        ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 60,),
                              Text('Your Workout Summary', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),),
                            ],
                          )
                          ],
                        ),
                      ),
                      Container(
                        height: 155,
//                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(icon: Icon(Icons.settings_applications,
                                color: Colors.blue,), onPressed: () {
                                Navigator.of(context).pushNamed(UserInfoScreen.routeName);
                              },),
                              SizedBox(height: 4,),
//                              MonthsDrop()
                            ]
                        ),
                      )
                    ],
                  ),
                  MusclesDiagramList(),
                ],

              ),
            )
          ],
        ),
    );
  }
}
