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
          case 8:
            return '${DateTime.now().month}/8';
          case 15:
            return '${DateTime.now().month}/15';
          case 22:
            return '${DateTime.now().month}/22';
          case 29:
            return '${DateTime.now().month}/29';
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
        // switch(value.toInt()){

        //   case 0:
        //     return '20';
        //   case 1:
        //     return '40';
        //   case 2:
        //     return '60';
        //   case 3:
        //     return '80';

        // }
        // return '';
      },
      getTextStyles: (value) => const TextStyle(
        color: Colors.white
      )
    ),
  );


}