import 'package:cgpa_calculator/model/semester_model.dart';
import 'package:cgpa_calculator/provider/semester_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSemesterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddSemesterScreen();

}

class _AddSemesterScreen extends State<AddSemesterScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final TextEditingController _semesterController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final semester_provider = Provider.of<SemesterProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Semester', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 16),
            TextField(
              controller: _semesterController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Semester Name (Semester 1)',
                errorText: _errorText,
                border: OutlineInputBorder(),
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
                    if (_validateAndSubmit()){
                      semester_provider.addSemester(SemesterModel(semester_name: _semesterController.text, semester_gpa: "0.0")),
                      Navigator.pop(context)
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

  String? _errorText;

  bool _validateAndSubmit() {
    String text = _semesterController.text;

    if (text.isEmpty) {
      setState(() {
        _errorText = 'Enter Semester Name';
      });
      return false;
    } else {
      return true;
    }
  }


}