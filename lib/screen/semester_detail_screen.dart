import 'package:cgpa_calculator/model/course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/courses_provider.dart';
import 'add_course_screen.dart';

class SemesterDetailScreen extends StatefulWidget{
  final int? semesterId;
  final String? semesterName;
  const SemesterDetailScreen(this.semesterId,this.semesterName);

  @override
  State<StatefulWidget> createState() => _SemesterDetailScreen();

}

class _SemesterDetailScreen extends State<SemesterDetailScreen>{

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
    final course_provider = Provider.of<CoursesProvider>(context);
    course_provider.loadCourses(semesterName!);
    return Scaffold(appBar: AppBar(
      title: Text('Semester Detail'),
    ),
        body : course_provider.courses.isEmpty
        ? Center(child: Container(child: Text('No Data Found'),))
            :Center(child: Container(child:
        ListView.builder(itemCount: course_provider.courses.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                InkWell(
                  child: Container(width: double.infinity,
                    child: Card(margin: EdgeInsets.only(top: 10 , left: 8 , right: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 10, right: 10),
                        child: Column(
                          children: [
                            // Text(task_provider.tasks[index].isDone == 1 ? "Done" : "Pending" ,style: TextStyle(color: Colors.red),),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Spacing between text and checkbox
                                  children: [
                                    // Text("Mark as Done"),

                                    Text(course_provider.courses[index].course_name! ,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                    Text('GPA : ${course_provider.courses[index].course_grade!}' ,style: TextStyle(color: Colors.red),),

                                  ],

                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Spacing between text and checkbox
                                  children: [
                                    // Text("Mark as Done"),

                                    Text(course_provider.courses[index].course_number! ,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                    Text('GPA : ${course_provider.courses[index].course_credit!}' ,style: TextStyle(color: Colors.red),),

                                  ],

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        )
        )
        ,floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Add Course',
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => AddCourseScreen(semesterId,semesterName),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

}