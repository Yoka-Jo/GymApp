import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class LineTitles{
  static getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
//      margin: 15,
      showTitles: true,
      getTitles: (value) {
        switch(value.toInt()){
          case 1:
            return '${DateTime.now().month}/1';
          case 7:
            return '${DateTime.now().month}/7';
          case 13:
            return '${DateTime.now().month}/13';
          case 19:
            return '${DateTime.now().month}/19';
          case 25:
            return '${DateTime.now().month}/25';
          case 31:
            return '${DateTime.now().month}/31';
        }
        return '';
      },
      getTextStyles: (value) => const TextStyle(
      color: Colors.white
  ),
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTitles: (value) {
        if(value.toInt()%20 ==0){
        return (value).toInt().toString();
        }
        return "";
      },
      getTextStyles: (value) => const TextStyle(
        color: Colors.white
      )
    ),
  );


}