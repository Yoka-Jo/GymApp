import 'package:flutter/material.dart';
import '../../shared/constants/Gym_Data.dart';
import '../../provider_HB/provider_HB.dart';
import 'package:provider/provider.dart';
class ChooseMuscleGroup extends StatefulWidget {
  @override
  _ChooseMuscleGroupState createState() => _ChooseMuscleGroupState();
}

class _ChooseMuscleGroupState extends State<ChooseMuscleGroup> {



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Choose Muscle Group',
          style: TextStyle(
              color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff2D2940),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(children: [
              Image.asset('assets/images/${musclePhoto[Provider.of<ProviderHelper>(context).selectedMuscle]}.png' , width: 20,),
              SizedBox(width: 10,),
              VerticalDivider(
                endIndent: 10,
                indent: 10,
                color: Colors.white30,
              ),
              SizedBox(width: 10,),
              Text(
                '${Provider.of<ProviderHelper>(context).selectedMuscle.split(' ').first}',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Provider.of<ProviderHelper>(context , listen: false).androidDropDown(),
            ])),
      ]),
    );
  }
}
