import 'package:flutter/material.dart';
class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2940),
      body: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Loading...' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
          SizedBox(width: 10,),
          CircularProgressIndicator()
        ],
      )),
    );
  }
}
