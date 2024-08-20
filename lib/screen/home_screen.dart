
import 'package:cgpa_calculator/screen/semester_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/semester_provider.dart';
import 'add_semester_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();


}

class _HomeScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    final semester_provider = Provider.of<SemesterProvider>(context);
    semester_provider.loadSemesters();

    return Scaffold(
      appBar: AppBar(title : Text("CGPA Calculator", )),
      body: ListView.builder(itemCount: semester_provider.semesters.length,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Spacing between text and checkbox
                            children: [
                              // Text("Mark as Done"),

                              Text(semester_provider.semesters[index].semester_name! ,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                              Text('GPA : ${semester_provider.semesters[index].semester_gpa!}' ,style: TextStyle(color: Colors.red),),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () =>{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SemesterDetailScreen(semester_provider.semesters[index].id!,semester_provider.semesters[index].semester_name!)))

                  // task_provider.deleteTask(task_provider.tasks[index].id!)
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Add Semester',
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => AddSemesterScreen(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

}