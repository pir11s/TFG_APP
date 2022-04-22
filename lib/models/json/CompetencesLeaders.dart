class CompetencesLeaders {
  List<CompetenceLeader>? leaders;

  CompetencesLeaders({this.leaders});

  CompetencesLeaders.fromJson(Map<String, dynamic> json) {
    if (json['competences'] != null) {
      leaders = <CompetenceLeader>[];
      json['competences'].forEach((v) {
        leaders!.add(new CompetenceLeader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaders != null) {
      data['competences'] = this.leaders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompetenceLeader {
  String? competenceName;
  String? employeeName;

  CompetenceLeader({this.competenceName, this.employeeName});

  CompetenceLeader.fromJson(Map<String, dynamic> json) {
    competenceName = json['Competence_Name'];
    employeeName = json['Employee_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Competence_Name'] = this.competenceName;
    data['Employee_Name'] = this.employeeName;
    return data;
  }
}
