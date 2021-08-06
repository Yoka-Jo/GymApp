import 'package:flutter/material.dart';
import 'package:test_app/shared/components/background.dart';
import '../widgets/last_work_out_widgets/addNewExerciseButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LastWorkOutScreen extends StatelessWidget {
  static const routeName = '/newWorkOut';
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.0,
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
          text: TextSpan(children: [
            TextSpan(
              text: 'Last  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 23),
            ),
            TextSpan(
              text: 'Work',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontSize: 18),
            ),
            TextSpan(
              text: ' Out',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontSize: 18),
            ),
          ]),
        ),
      ),
      body: Stack(children: [
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
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Last Work Out :',
                style:
                    TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("usersExercises")
                      .doc(user)
                      .collection('newExercise')
                      .orderBy('id')
                      .snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
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
                              borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                            ? data[data.length - 1]['id']
                                                .split(' ')
                                                .first
                                            : '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(top: 30),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                lastWorkOutData("Muscle",data.length > 0 ? data[data.length - 1]['muscle'].split(' ').first : ""),
                                SizedBox(
                                  height: 15,
                                ),
                                lastWorkOutData("Number of Sets", data.length > 0? data[data.length - 1]['setsNumber'].toString() : ""),
                                SizedBox(
                                  height: 15,
                                ),
                                lastWorkOutData("Max Weight", data.length > 0? data[data.length - 1]['maxWeight'].toString() : ""),
                                SizedBox(
                                  height: 15,
                                ),
                                lastWorkOutData("Exercise Type", data.length > 0? data[data.length - 1]['exerciseType'] : ""),
                              ],
                            ),
                          ),
              SizedBox(
                height: 40,
              ),
              AddNewExerciseButton()
                        ],
                        
                      );
                    }
                  }),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget lastWorkOutData(String leadingTitle , String data) => Row(
        children: [
          Text(leadingTitle,
              style:
                  TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold)),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15.0,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            width: 150.0,
            child: Text(data,
                style:
                // Color(0xff37779A), Color(0xff46DFC9)
                    TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white, fontWeight: FontWeight.bold , fontSize: 16.0 ,backgroundColor: Color(0xff232035))),
          )
        ],
      );
}
