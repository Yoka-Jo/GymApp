import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider_HB/provider_HB.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
class SaveButton extends StatelessWidget {

  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context, listen: false);
    print(provider.weightList.length);
    final user = FirebaseAuth.instance.currentUser.uid;

    return GestureDetector(
      onTap: () async {
        if (provider.formKey.currentState.validate() &&
            provider.selectedItem.isNotEmpty) {
          provider.formKey.currentState.save();
          Navigator.of(context).pop();
          final time = DateTime.now();
          List<double> weight = provider.weightList.map(double.parse).toList();
          await FirebaseFirestore.instance
              .collection(user).doc('user').collection('newExercise').
              doc(time.toString())
              .set({
            'muscle': provider.selectedMuscle,
            'exerciseType': provider.selectedItem,
            'setsNumber': provider.setsNumber + 1,
            'reps': provider.repsList,
            'weight': provider.weightList,
            'specificWeight': weight.fold(weight[0],max),
            'timeInDetail': DateFormat.MMMEd().format(DateTime.now()),
            'timePoints': DateTime
                .now()
                .day,
            'id': time.toString()
          });
          await FirebaseFirestore.instance
              .collection(user).doc('user').collection('diagramPoints').
          doc(time.toString())
              .set({
            'muscle': provider.selectedMuscle,
            'weight': weight.fold(weight[0],max),
            'timePoints': DateTime
                .now()
                .day,
            'id': time.toString()
          });
          await FirebaseFirestore.instance
              .collection(user).doc('user').collection('events').
          doc(time.toString())
              .set({
            'data': DateTime
                .now(),
            'id': time.toString()
          });
          provider.reset();
        }
        else{
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Complete The Form!' , style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        height: 50,
        width: 310,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff37779A), Color(0xff46DFC9)]),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
            child: Text('Save',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
