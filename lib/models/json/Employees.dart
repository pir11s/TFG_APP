class Employees {
  List<Employee>? employees;

  Employees({this.employees});

  Employees.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employees = <Employee>[];
      json['employees'].forEach((v) {
        employees!.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employee {
  String? id;
  String? name;
  String? competence;
  String? groupFunction;

  Employee({this.id, this.name, this.competence, this.groupFunction});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    competence = json['competence'];
    groupFunction = json['groupFunction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['competence'] = this.competence;
    data['groupFunction'] = this.groupFunction;
    return data;
  }
}
