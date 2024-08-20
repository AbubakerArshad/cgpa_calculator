import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../model/semester_model.dart';

class SemesterProvider with ChangeNotifier{

  List<SemesterModel> _semesters = [];

  List<SemesterModel> get semesters => _semesters;

  Future<void> loadSemesters() async {
    _semesters = await dbHelper.getSemestersList();
    notifyListeners();
  }

  void addSemester(SemesterModel semester) {
    Map<String, dynamic> row = {
      "semester_name": semester.semester_name,
      "semester_gpa": semester.semester_gpa
    };
   var id = dbHelper.createSemester(row);
   print("SEMESTER ID $id");
    notifyListeners();
  }

  void updateSemesterGPA(SemesterModel semester){
    Map<String, dynamic> row = {
      "id": semester.id,
      "semester_name": semester.semester_name,
      "semester_gpa": semester.semester_gpa
    };
    var id = dbHelper.updateSemesterGPA(row);
    print("SEMESTER UDPATED ID $id");
    notifyListeners();
  }

}