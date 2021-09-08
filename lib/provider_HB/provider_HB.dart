import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/models/exercise_model.dart';
import 'package:test_app/models/exercise_type_model.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/screens/home/date_screen.dart';
import 'package:test_app/screens/home/exercises_info_screen.dart';
import 'package:test_app/shared/constants/constants.dart';
import '../shared/constants/Gym_Data.dart';

class ProviderHelper with ChangeNotifier {
  String _selectedExerciseType;
  int _setsNumber = 0;
  var _selectedMuscle = 'Chest';
  String repsValue;
  String weightValue;
  List<String> repsList = [null];
  List<String> weightList = [null];
  final formKey = GlobalKey<FormState>();

  String get selectedItem => _selectedExerciseType;

  String get selectedMuscle => _selectedMuscle;

  int get setsNumber => _setsNumber;

  void updateColor(String value) {
    if (_selectedExerciseType == value) {
      _selectedExerciseType = null;
      notifyListeners();
    } else {
      _selectedExerciseType = value;
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
    _selectedExerciseType = null;
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

  PopupMenuButton<String> dropDownMenu() {
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

  UserModel model;

  Future<void> getUserData() async {
    final users =
        await FirebaseFirestore.instance.collection('emails').doc(uId).get();
    model = UserModel.fromJson(users.data());
    notifyListeners();
  }

  bool isPostUserExercise = false;

  Future<void> postUserExercise(context) async {
    isPostUserExercise = true;
    notifyListeners();
    if (formKey.currentState.validate() && _selectedExerciseType != null) {
      formKey.currentState.save();
      final time = DateTime.now();
      List<double> weight = weightList.map(double.parse).toList();

      ExerciseModel model = ExerciseModel(
        id: time.toString(),
        muscle: _selectedMuscle,
        exerciseType: _selectedExerciseType,
        exerciseTime: DateFormat.MMMEd().format(DateTime.now()),
        calendarDate: DateTime.now().toString(),
        setsNumber: _setsNumber + 1,
        reps: repsList,
        weights: weightList,
        maxWeight: weight.fold(weight[0], max),
        pointTime: DateTime.now().day.toString(),
      );
      await FirebaseFirestore.instance
          .collection("usersExercises")
          .doc(uId)
          .collection('newExercise')
          .doc(time.toString())
          .set(model.toMap());
      reset();
      isPostUserExercise = false;
      notifyListeners();
    } else {
      isPostUserExercise = false;
      notifyListeners();
      return Future.error(
          "This is the error", StackTrace.fromString("This is its trace"));
    }
  }

  List<ExerciseModel> exercises = [];
  bool getExercisesLoading = false;
  Future<void> getUserExercises() async {
    exercises = [];
    getExercisesLoading = true;
    notifyListeners();
    final fetchedExercises = await FirebaseFirestore.instance
        .collection("usersExercises")
        .doc(uId)
        .collection('newExercise')
        .orderBy('id', descending: false)
        .get();

    fetchedExercises.docs.forEach((element) {
      exercises.add(ExerciseModel.fromJson(element.data()));
    });
    getExercisesLoading = false;
    notifyListeners();
  }

  bool isUpdated = false;
  Future<void> updateUser({String name, String height, String weight}) async {
    isUpdated = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection("emails").doc(uId).update({
      "userName": name.isEmpty ? model.name : name,
      "weight": weight.isEmpty ? model.weight : int.parse(weight),
      "height": height.isEmpty ? model.height : int.parse(height)
    });

    isUpdated = false;
    notifyListeners();
    return await getUserData();
  }

  Future<void> postExerciseType(String value) async {
    String timeExerciseTypeCreated = Timestamp.now().toString();
    ExerciseTypeModel exerciseTypeModel =
        ExerciseTypeModel(createdAt: timeExerciseTypeCreated, title: value);

    await FirebaseFirestore.instance
        .collection('exercisesType')
        .doc(timeExerciseTypeCreated)
        .set(exerciseTypeModel.toMap());
    getExerciseTypes();
  }

  List<ExerciseTypeModel> exericseTypes = [];
  bool getExericseTypesLoading = false;
  Future<void> getExerciseTypes() async {
    exericseTypes = [];
    getExericseTypesLoading = true;
    notifyListeners();
    final fetchedExercisesType =
        await FirebaseFirestore.instance.collection('exercisesType').get();
    fetchedExercisesType.docs.forEach((element) {
      exericseTypes.add(ExerciseTypeModel.fromJson(element.data()));
    });
    getExericseTypesLoading = false;
    notifyListeners();
  }

  Future<void> deleteExerciseType(String exerciseTypeId) async {
    ExerciseTypeModel backupExerciseType = exericseTypes
        .firstWhere((element) => element.createdAt == exerciseTypeId);
    try {
      await FirebaseFirestore.instance
          .collection('exercisesType')
          .doc(exerciseTypeId)
          .delete();
      exericseTypes
          .removeWhere((element) => element.createdAt == exerciseTypeId);
      notifyListeners();
    } catch (error) {
      exericseTypes.add(backupExerciseType);
      notifyListeners();
    }
  }

  void deleteExercise(String exerciseId) {
    ExerciseModel backupExercise =
        exercises.firstWhere((element) => element.id == exerciseId);
    final docPath =
        FirebaseFirestore.instance.collection("usersExercises").doc(uId);
    try {
      docPath.collection('newExercise').doc(exerciseId).delete();
      exercises.removeWhere((element) => element.id == exerciseId);
      notifyListeners();
    } catch (error) {
      exercises.add(backupExercise);
      notifyListeners();
    }
  }

  int navIndex = 0;
  List<Widget> navScreens = [ExercisesInfoScreen(), DateScreen()];
  void changeNavIndex(int index) {
    navIndex = index;
    notifyListeners();
  }
}
