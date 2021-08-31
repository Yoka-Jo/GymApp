import 'package:flutter/material.dart';

class BackgroundColor extends StatelessWidget {
  final Widget onBackgroundWidget;
  const BackgroundColor({@required this.onBackgroundWidget});
  @override
  Widget build(BuildContext context) {
  final double fillPercent = 65.0; // fills 56.23% for container from bottom
  final double fillStop = (100 - fillPercent) / 100;
    return Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(
          colors: [Color(0xff232035) ,Color(0xff232035) , Color(0xff2D2940)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, fillStop, fillStop]
        ) 
      ),
      child: onBackgroundWidget,
    );
  }
}
