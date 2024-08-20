import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../model/course_model.dart';

class CoursesProvider with ChangeNotifier{

  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  Future<void> loadCourses(String course_semester) async {
    _courses = await dbHelper.getCoursesList(course_semester);
    notifyListeners();
  }

  void addCourse(CourseModel semester) {
    Map<String, dynamic> row = {
      "course_name": semester.course_name,
      "course_grade": semester.course_grade,
      "course_number": semester.course_number,
      "course_credit": semester.course_credit,
      "course_semester": semester.course_semester
    };
    var id = dbHelper.createCourse(row);
    print("SEMESTER ID $id");
    notifyListeners();
  }
}