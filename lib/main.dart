import 'package:flutter/material.dart';
import 'screens/login/logo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'shared/components/splach_screen.dart';
import './screens/home/date_screen.dart';
import 'screens/last_work_out_screen.dart';
import 'screens/add_new_exercise_screen.dart';
import 'package:provider/provider.dart';
import './provider_HB/provider_HB.dart';
import './screens/home/userInfo_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderHelper()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         appBarTheme: AppBarTheme(
             color: Color(0xff232035),
           elevation: 0,
           brightness: Brightness.dark,
         ),
        ),
        title: 'Gym App',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context , snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return SplachScreen();
                }
                if (snapShot.hasData) {
                  return ChosenScreen();
                }
                return LogoScreen();
              }
              ),
        routes: {
          ChosenScreen.routeName : (context) => ChosenScreen(),
          DateScreen.routeName: (context) => DateScreen(),
          LastWorkOutScreen.routeName: (context) => LastWorkOutScreen(),
          AddNewExerciseScreen.routeName: (context) => AddNewExerciseScreen(),
          UserInfoScreen.routeName:(context) => UserInfoScreen()
        },
      ),
    );
  }
}

