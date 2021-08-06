import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import '../last_work_out_screen.dart';

class ChosenScreen extends StatelessWidget {
  static const routeName = '/UserInfo';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(LastWorkOutScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff39364B),
        onTap: provider.changeNavIndex,
        currentIndex: provider.navIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_outlined), label: 'Date'),
        ],
      ),
      body: provider.navScreens[provider.navIndex],
    );
  }
}
