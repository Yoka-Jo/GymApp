import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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


  DropdownButton<String> monthsDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var months in Months) {
      var newItem = DropdownMenuItem(
        child: Text(months),
        value: months,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton(
      underline: Container(),
      value: selectedMonth,
      items: dropDownItems,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white54,
      ),
      dropdownColor: Color(0xff2D2940),
      style: TextStyle(color: Colors.white),
      onChanged: (value) {
        selectedMonth = value;
        notifyListeners();
      },
    );
  }
}
