import 'package:flutter/material.dart';
import 'package:test_app/shared/constants/constants.dart';
import 'package:test_app/shared/network/local/cache_helper.dart';
import 'screens/login/logo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home/home_screen.dart';
import './screens/home/date_screen.dart';
import 'screens/last_work_out_screen.dart';
import 'screens/add_new_exercise_screen.dart';
import 'package:provider/provider.dart';
import './provider_HB/provider_HB.dart';
import './screens/home/userInfo_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: "uId");
  Widget widget;
  if(uId != null){
  widget = HomeScreen();
  }
  else{
    widget = LogoScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderHelper()..getUserExercises()..getExerciseTypes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.transparent,
        ),
         appBarTheme: AppBarTheme(
             color: Color(0xff232035),
           elevation: 0,
           brightness: Brightness.dark,
         ),
        ),
        title: 'Gym App',
        home: startWidget,
        routes: {
          HomeScreen.routeName : (context) => HomeScreen(),
          DateScreen.routeName: (context) => DateScreen(),
          LastWorkOutScreen.routeName: (context) => LastWorkOutScreen(),
          AddNewExerciseScreen.routeName: (context) => AddNewExerciseScreen(),
          UserInfoScreen.routeName:(context) => UserInfoScreen()
        },
      ),
    );
  }
}

