class CourseModel{
  int? id;
  String? course_name;
  String? course_grade;
  String? course_number;
  String? course_credit;
  String? course_semester;

  CourseModel({this.id, this.course_name,this.course_grade, this.course_number,this.course_credit, this.course_semester,});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course_name = json['course_name'];
    course_grade = json['course_grade'];
    course_number = json['course_number'];
    course_credit = json['course_credit'];
    course_semester = json['course_credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.course_name;
    data['course_grade'] = this.course_grade;
    data['course_number'] = this.course_number;
    data['course_credit'] = this.course_credit;
    data['course_semester'] = this.course_semester;
    return data;
  }

  // Convert a Map into a Todo.
  static CourseModel fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      course_name: map['course_name'],
      course_grade: map['course_grade'],
      course_number: map['course_number'],
      course_credit: map['course_credit'],
      course_semester: map['course_semester'],
    );
  }
}