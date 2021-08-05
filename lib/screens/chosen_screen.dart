import 'package:flutter/material.dart';
import '../screens/date_screen.dart';
import '../screens/newWorkOut_screen.dart';
import '../screens/welcome_screen.dart';
class ChosenScreen extends StatefulWidget {
  static const routeName = '/UserInfo';

  @override
  _ChosenScreenState createState() => _ChosenScreenState();
}

class _ChosenScreenState extends State<ChosenScreen> {
 int _selectedPage = 0;

 

 void _selectPage(int index){
   setState(() {
     _selectedPage = index;
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(NewWorkOut.routeName);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff39364B),
        onTap: _selectPage,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_outlined), label: 'Date'),
        ],
      ),
      body: _selectedPage == 0 ?  WelcomeScreen() : DateScreen(),
    );
  }
}

