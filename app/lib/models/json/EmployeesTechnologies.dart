class EmployeesTechnologies {
  List<EmployeeTechnology>? employeesTechnologies;

  EmployeesTechnologies({this.employeesTechnologies});

  EmployeesTechnologies.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employeesTechnologies = <EmployeeTechnology>[];
      json['employees'].forEach((v) {
        employeesTechnologies!.add(new EmployeeTechnology.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeesTechnologies != null) {
      data['employees'] = this.employeesTechnologies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeTechnology {
  String? employeeName;
  String? competenceName;
  String? technology;
  String? skillLevel;

  EmployeeTechnology(
      {this.employeeName,
      this.competenceName,
      this.technology,
      this.skillLevel});

  EmployeeTechnology.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    competenceName = json['competenceName'];
    technology = json['technology'];
    skillLevel = json['skillLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeName'] = this.employeeName;
    data['competenceName'] = this.competenceName;
    data['technology'] = this.technology;
    data['skillLevel'] = this.skillLevel;
    return data;
  }
}
