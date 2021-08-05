import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DropDownItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Color(0xff2D2940),
    underline: Container(),
    icon: Icon(
    Icons.settings_outlined,
    color: Colors.white,
    ),
    items: [
    DropdownMenuItem(
    child: Container(
    child: Row(children: [
    Icon(
    Icons.exit_to_app,
    color: Colors.white,
    ),
    SizedBox(
    width: 18,
    ),
    Text('Logout' , style: TextStyle(color: Colors.white),),
    ]),
    ),
    value: 'Logout',
    ),
    ],
    onChanged: (itemIdentifier) {
    if (itemIdentifier == 'Logout') {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
    }
    },
);
  }
}
