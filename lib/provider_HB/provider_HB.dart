import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/models/exercise_model.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/screens/home/date_screen.dart';
import 'package:test_app/screens/home/welcome_screen.dart';
import 'package:test_app/shared/constants/constants.dart';
import '../shared/constants/Gym_Data.dart';

class ProviderHelper with ChangeNotifier {
  String _selectedItem;
  int _setsNumber = 0;
  var _selectedMuscle = 'Chest';
  String repsValue;
  String weightValue;
  List<String> repsList = [null];
  List<String> weightList = [null];
  final formKey = GlobalKey<FormState>();
  int rePeat = 0;
  String selectedMonth = 'January';

  void oK() {
    rePeat = 1;
    notifyListeners();
  }

  void nO() {
    rePeat = 0;
    notifyListeners();
  }

  String get selectedItem {
    return _selectedItem;
  }

  String get selectedMuscle {
    return _selectedMuscle;
  }

  int get setsNumber {
    return _setsNumber;
  }

  void updateColor(String value) {
    if (selectedItem == value) {
      _selectedItem = null;
      notifyListeners();
    } else {
      _selectedItem = value;
      notifyListeners();
    }
  }

  void increaseSets() {
    repsList.insert(0, null);
    notifyListeners();
    weightList.insert(0, null);
    notifyListeners();
    _setsNumber++;
    notifyListeners();
  }

  void reset() {
    repsList = [null];
    weightList = [null];
    _setsNumber = 0;
    _selectedItem = null;
    _selectedMuscle = 'Chest';
    notifyListeners();
  }

  void decreaseSets(int index) {
    if (_setsNumber > 0) {
      repsList.removeAt(index);
      notifyListeners();
      weightList.removeAt(index);
      notifyListeners();
      _setsNumber--;
      notifyListeners();
    } else {
      return;
    }
  }

  PopupMenuButton<String> androidDropDown() {
    List<PopupMenuItem<String>> dropDownItems = [];
    for (var data in muscleGroup) {
      var newItem = PopupMenuItem(
        child: Text(
          data,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        value: data,
      );
      dropDownItems.add(newItem);
    }
    return PopupMenuButton<String>(
        color: Color(0xff2D2940),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white54,
        ),
        itemBuilder: (_) => dropDownItems,
        onSelected: (value) {
          _selectedMuscle = value;
          notifyListeners();
        });
  }

  void submitReps(String value) {
    repsValue = value;
    notifyListeners();
  }

  void submitWeight(String value) {
    weightValue = value;
    notifyListeners();
  }



  // final user = FirebaseAuth.instance.currentUser;
  UserModel model;

  void getUserData() {
    FirebaseFirestore.instance
        .collection('emails')
        .doc(uId)
        .get()
        .then((value) {
      print(value);
      model = UserModel.fromJson(value.data());
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  bool isPostUserExercise = false;

  Future<void> postUserExercise(context) async {
    isPostUserExercise = true;
    notifyListeners();
    if (formKey.currentState.validate() && selectedItem != null) {
      formKey.currentState.save();
      final time = DateTime.now();
      List<double> weight = weightList.map(double.parse).toList();

      ExerciseModel model = ExerciseModel(
          id: time.toString(),
          muscle: selectedMuscle,
          exerciseType: selectedItem,
          exerciseTime: DateFormat.MMMEd().format(DateTime.now()),
          setsNumber: setsNumber + 1,
          reps: repsList,
          weights: weightList,
          maxWeight: weight.fold(weight[0], max),
          pointTime: DateTime.now().day.toString());

      await FirebaseFirestore.instance
          .collection("usersExercises")
          .doc(uId)
          .collection('newExercise')
          .doc(time.toString())
          .set(model.toMap());
      await FirebaseFirestore.instance
          .collection("usersExercises")
          .doc(uId)
          .collection('diagramPoints')
          .doc(time.toString())
          .set({
        'muscle': selectedMuscle,
        'weight': weight.fold(weight[0], max),
        'pointTime': DateTime.now().day,
        'id': time.toString()
      });
      await FirebaseFirestore.instance
          .collection("usersExercises")
          .doc(uId)
          .collection('events')
          .doc(time.toString())
          .set({'data': DateTime.now(), 'id': time.toString()});
        reset();
        isPostUserExercise = false;
        notifyListeners();
    } else {
      isPostUserExercise = false;
      notifyListeners();
      return Future.error("This is the error", StackTrace.fromString("This is its trace"));
    }
  }

  bool isUpdated = false;
  void updateUser({String name, String height, String weight}) {
    isUpdated = true;
    notifyListeners();
    FirebaseFirestore.instance.collection("emails").doc(uId).update({
      "userName": name.isEmpty ? model.name : name,
      "weight": weight.isEmpty ? model.weight : int.parse(weight),
      "height": height.isEmpty ? model.height : int.parse(height)
    }).then((value) {
      isUpdated = false;
      notifyListeners();
      getUserData();
    });
  }

  int navIndex = 0;
  List<Widget> navScreens = [WelcomeScreen(), DateScreen()];
  void changeNavIndex(int index) {
    navIndex = index;
    notifyListeners();
  }
}
