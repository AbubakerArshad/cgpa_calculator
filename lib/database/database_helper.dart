import 'package:cgpa_calculator/model/course_model.dart';
import 'package:cgpa_calculator/model/semester_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = "cgpa_calculator.db";
  static const _databaseVersion = 1;

  static const semester_table = 'semester_table';
  static const courses_table = 'courses_table';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {

    await db.execute('''
          CREATE TABLE $semester_table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
           semester_name TEXT NOT NULL,
            semester_gpa TEXT NOT NULL
                    )
          ''');

    await db.execute('''
          CREATE TABLE $courses_table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
           course_name TEXT NOT NULL,
            course_grade TEXT NOT NULL,
            course_number TEXT NOT NULL,
            course_credit TEXT NOT NULL,
            course_semester TEXT NOT NULL
                    )
          ''');

  }

  Future<int> createSemester(Map<String, dynamic> row) async{
    return await _db.insert(semester_table, row);
  }

  Future<List<SemesterModel>> getSemestersList() async {
    final List<Map<String, dynamic>> maps = await _db.query(semester_table);

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return SemesterModel.fromMap(maps[i]);
    });
  }

  Future<int> updateSemesterGPA(Map<String, dynamic> row) async {
    int id = row["id"];
    return await _db.update(
      semester_table,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<int> createCourse(Map<String, dynamic> row) async{
    return await _db.insert(courses_table, row);
  }

  Future<List<CourseModel>> getCoursesList(String course_semester) async {
    final List<Map<String, dynamic>> maps = await _db.query(courses_table, where: 'course_semester = ?',
      whereArgs: [course_semester],);

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return CourseModel.fromMap(maps[i]);
    });
  }


}