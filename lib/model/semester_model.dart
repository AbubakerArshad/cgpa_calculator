class SemesterModel {
  int? id;
  String? semester_name;
  String? semester_gpa;

  SemesterModel({this.id, this.semester_name,this.semester_gpa});

  SemesterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    semester_name = json['semester_name'];
    semester_gpa = json['semester_gpa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['semester_name'] = this.semester_name;
    data['semester_gpa'] = this.semester_gpa;
    return data;
  }

  // Convert a Map into a Todo.
  static SemesterModel fromMap(Map<String, dynamic> map) {
    return SemesterModel(
      id: map['id'],
      semester_name: map['semester_name'],
      semester_gpa: map['semester_gpa'],
    );
  }
}