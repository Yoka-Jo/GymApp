import 'package:flutter/material.dart';
import '../widgets/dropDownItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/components/splach_screen.dart';
class UserInfoScreen extends StatelessWidget {
  static const routeName = '/UserInfoScreen';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('emails').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Color(0xff2D2940),
                height: double.infinity,
                width: double.infinity,
                child: SplachScreen());
          }
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data.data();
              return Stack(
                children: [
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
                        height: 140,
//                      width: double.infinity,
                        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['userName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                DropDownItem(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.line_weight,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(data['weight'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  width: 7,
                                ),
                                VerticalDivider(
                                  thickness: .9,
                                  color: Colors.white30,
                                ),
                                Icon(
                                  Icons.height,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(data['height'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(0, 15)),
                          ],
                          color: Color(0xff2D2940),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                width: double.infinity,
                                child: Text(
                                  'Personal Info',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                )),
                            Divider(
                              color: Colors.white30,
                              indent: 20,
                              endIndent: 20,
                            ),
                            WidgetName(
                              name: 'Full Name',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WidgetInfo(
                              icon: Icons.person_outline,
                              name: data['userName'],
                              rightPadding: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WidgetName(
                              name: 'Weight',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WidgetInfo(
                              icon: Icons.line_weight,
                              name: data['weight'].toString(),
                              rightPadding: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WidgetName(
                              name: 'height',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WidgetInfo(
                              icon: Icons.height,
                              name: data['height'].toString(),
                              rightPadding: 140,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Go' , style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30),),
                          SizedBox(width: 20,),
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.blue,
                            iconSize: 50,
                          ),
                          Text('Back' , style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30),),
                        ],
                      )
                    ],
                  )
                ],
              );
            }
          } catch (e) {
            return Center(child: Text('$e'));
          }
          return null;
        },
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  final IconData icon;
  final String name;
  final double rightPadding;

  const WidgetInfo({@required this.rightPadding, this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: rightPadding),
      height: 50,
      width: 282,
      decoration: BoxDecoration(
        color: Color(0xff39364B),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class WidgetName extends StatelessWidget {
  final String name;

  const WidgetName({this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 10),
        width: double.infinity,
        child: Text(
          name,
          style: TextStyle(color: Colors.white30, fontWeight: FontWeight.w500),
        ));
  }
}
