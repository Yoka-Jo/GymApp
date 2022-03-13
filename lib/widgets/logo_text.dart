import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String textName;
  final Function onTap;

  const LogoText({this.textName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        textName,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.lightBlue, fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
