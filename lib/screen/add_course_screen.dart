import 'package:cgpa_calculator/model/course_model.dart';
import 'package:cgpa_calculator/model/semester_model.dart';
import 'package:cgpa_calculator/provider/courses_provider.dart';
import 'package:cgpa_calculator/provider/semester_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourseScreen extends StatefulWidget{
  final int? semesterId;
  final String? semesterName;

  const AddCourseScreen(this.semesterId,this.semesterName);

  @override
  State<StatefulWidget> createState() => _AddCourseScreen();

}

class _AddCourseScreen extends State<AddCourseScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseGradeController = TextEditingController();
  final TextEditingController _courseCreditController = TextEditingController();
  late CoursesProvider course_provider;
  late SemesterProvider semester_provider;

  late int? semesterId;
  late String? semesterName;

  @override
  void initState() {
    super.initState();
    semesterId = widget.semesterId;
    semesterName = widget.semesterName;

  }

  @override
  Widget build(BuildContext context) {
    course_provider = Provider.of<CoursesProvider>(context);
    semester_provider = Provider.of<SemesterProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Course', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 16),
            TextField(
              controller: _courseNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Course Name',
                errorText: _errorCourseNameText,
                border: OutlineInputBorder(),
              ),
            ),Container(margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _courseGradeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Course Grade(4.0)',
                  errorText: _errorCourseGradeText,
                  border: OutlineInputBorder(),
                ),
              ),
            ),Container(margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _courseCreditController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Credit Hour',
                  errorText: _errorCourseCreditText,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog without returning a value
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: ()=> {
                    if (_validateAndSubmit() && _validateGradeName() && _validateCourseCredit()){
                      // course_provider.addCourse(CourseModel(
                      //     course_name: _courseNameController.text,
                      //     course_grade: _semesterController.text,
                      //     course_number: _semesterController.text,
                      //     course_credit: _semesterController.text,
                      //     course_semester: _semesterController.text,
                      // )),
                      if(double.parse(_courseGradeController.text.toString()) > 3.6){
                        addCourse(_courseNameController.text, "A",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 3.3){
                        addCourse(_courseNameController.text, "A-",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 3.0){
                        addCourse(_courseNameController.text, "B+",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 2.7){
                        addCourse(_courseNameController.text, "B",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 2.3){
                        addCourse(_courseNameController.text, "B-",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 2.0){
                        addCourse(_courseNameController.text, "C+",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 1.7){
                        addCourse(_courseNameController.text, "C",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 1.3){
                        addCourse(_courseNameController.text, "C-",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else if(double.parse(_courseGradeController.text.toString()) >= 1.0){
                        addCourse(_courseNameController.text, "D",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }else {
                        addCourse(_courseNameController.text, "F",double.parse(_courseGradeController.text.toString()), _courseCreditController.text )
                      }
                      // Navigator.pop(context)
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _errorCourseNameText;
  String? _errorCourseGradeText;
  String? _errorCourseCreditText;

  bool _validateAndSubmit() {
    String text = _courseNameController.text;

    if (text.isEmpty) {
      setState(() {
        _errorCourseNameText = 'Enter Course Name';
      });
      return false;
    } else {
      return true;
    }
  }
  bool _validateGradeName() {
    String text = _courseGradeController.text;

    if (text.isEmpty) {
      setState(() {
        _errorCourseGradeText = 'Enter Course Name';
      });
      return false;
    } else {
      return true;
    }
  }bool _validateCourseCredit() {
    String text = _courseCreditController.text;

    if (text.isEmpty) {
      setState(() {
        _errorCourseCreditText = 'Enter Course Name';
      });
      return false;
    } else {
      return true;
    }
  }

  addCourse(String courseName, String courseGrade, double courseGpa, String creditHour) async {
    course_provider.addCourse(CourseModel(course_name: courseName,course_grade: courseGrade,course_number: courseGpa.toString(),
    course_credit: creditHour,course_semester: semesterName));
    await course_provider.loadCourses(semesterName!);
    updateSemesterGPA();
    // Navigator.pop(context);
  }

  void updateSemesterGPA() {
    var semesterGPA = 0.0;
    course_provider.courses.forEach((element) async {
      // _images.add(await getImageFileFromAssets(element));
      semesterGPA = semesterGPA + double.parse(element.course_number!);
    });
    var gpaOfSemester = semesterGPA / course_provider.courses.length;
    var semester = SemesterModel(
      id: semesterId,
      semester_name: semesterName,
      semester_gpa: gpaOfSemester.toString(),
    );
    semester_provider.updateSemesterGPA(semester);
    Navigator.pop(context);
  }


}