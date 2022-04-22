class EmployeesImages {
  List<EmployeeImage>? employeesImages;

  EmployeesImages({this.employeesImages});

  EmployeesImages.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employeesImages = <EmployeeImage>[];
      json['employees'].forEach((v) {
        employeesImages!.add(new EmployeeImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeesImages != null) {
      data['employees'] = this.employeesImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeImage {
  String? id;
  String? image;

  EmployeeImage({this.id, this.image});

  EmployeeImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
