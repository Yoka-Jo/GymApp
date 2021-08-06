import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'package:test_app/screens/home/userInfo_screen.dart';
import 'package:test_app/shared/components/background.dart';
import 'package:test_app/widgets/welcome_widgets/musclesDiagramList.dart';

class WelcomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProviderHelper>(context).model;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_applications,
              color: Colors.blue,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(UserInfoScreen.routeName);
            },
          ),
          SizedBox(
            width: 10.0,
          )
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME, ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 25),
              ),
              Builder(
                builder: (context) {
                  if (data == null) {
                    return Text('...');
                  }
                  try {
                    if (data != null) {
                      return Text(
                        data.name.split(' ').first,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          background(),
          Column(
            children: [
              SizedBox(height: 20.0,),
              Text(
                'Your Workout Summary',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
              SizedBox(height: 30.0,),
              MusclesDiagramList(),
            ],
          ),
        ],
      ),
    );
  }
}
