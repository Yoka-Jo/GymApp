import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/diagramList.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MusclesDiagramList extends StatefulWidget {
  @override
  _MusclesDiagramListState createState() => _MusclesDiagramListState();
}

class _MusclesDiagramListState extends State<MusclesDiagramList> {
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection(user).doc('user').collection('newExercise').orderBy('id' , descending:false)
                  .snapshots(),
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                else {
                  try {
                    final data = snapShot.data.docs;
                    return data.isEmpty ? Container() : Column(
                      children: [
                        ConstrainedBox(
                          constraints:   BoxConstraints(
                          minHeight: 35.0,
                          maxHeight: 140.0,
                        ),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 20 ,right: 20 , bottom: 8),
                            scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) =>
                                  Container(
                                    width: 135,
                                    margin: EdgeInsets.only(right: 20),
                                    padding: EdgeInsets.only(left: 10 , bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xff2D2940),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(-1 ,5 )
                                      )],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                            height: 55,
                                            width: 55,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle
                                              ),
                                              child: Center(child: Image.asset('assets/images/dum.png' , fit: BoxFit.cover,)),
                                            ),
                                            Text(data[index]['muscle'].split(' ').first,
                                              style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                                            Text(data[index]['timeInDetail'],
                                              style: TextStyle(color: Colors.white),)
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: PopupMenuButton(
                                            color: Color(0xff2D2940),
                                              icon: Icon(Icons.more_horiz,  color: Colors.blue,),
                                              onSelected: (value){
                                                FirebaseFirestore.instance.collection(user).doc('user').collection('newExercise').doc(data[index]['id']).delete();
                                                FirebaseFirestore.instance.collection(user).doc('user').collection('diagramPoints').doc(data[index]['id']).delete();
                                                FirebaseFirestore.instance.collection(user).doc('user').collection('events').doc(data[index]['id']).delete();
                                                setState(() {
                                                });
                                              },
                                              itemBuilder: (_)=>[
                                             PopupMenuItem(child: Text('Delete' , style: TextStyle(color: Colors.white),) , value: 0,)]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  }catch(e){
                    print(e);
                  }
                  return Container();
                }
              }
          ),
          Expanded(
          child: ListView(padding: EdgeInsets.only(top: 10), children: [
      ChartList('Bicebs'),
      ChartList('Triceps'),
      ChartList('Chest'),
      ChartList('calves'),
      ChartList('hamstrings'),
      ChartList('quadriceps'),
      ChartList('trapezius'),
      ChartList('forearms'),
      ]),
      )
        ],
      ),
    );
  }
}