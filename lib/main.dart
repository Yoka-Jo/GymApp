import 'package:flutter/material.dart';
import './screens/logo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/chosen_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'shared/components/splach_screen.dart';
import './screens/date_screen.dart';
import './screens/newWorkOut_screen.dart';
import './screens/addNewExercise_screen.dart';
import 'package:provider/provider.dart';
import './provider_HB/provider_HB.dart';
import './screens/userInfo_screen.dart';

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
      create: (context) => ProviderHelper(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         appBarTheme: AppBarTheme(
             color: Color(0xff232035),
           elevation: 0,
           brightness: Brightness.dark,
         ),
        ),
        title: 'Demo App',
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
          NewWorkOut.routeName: (context) => NewWorkOut(),
          AddNewWorkOut.routeName: (context) => AddNewWorkOut(),
          UserInfoScreen.routeName:(context) => UserInfoScreen()
        },
      ),
    );
  }
}

