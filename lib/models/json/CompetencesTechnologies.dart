class CompetencesTechnologies {
  List<Competences>? competences;

  CompetencesTechnologies({this.competences});

  CompetencesTechnologies.fromJson(Map<String, dynamic> json) {
    if (json['competences'] != null) {
      competences = <Competences>[];
      json['competences'].forEach((v) {
        competences!.add(new Competences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.competences != null) {
      data['competences'] = this.competences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Competences {
  String? technology;
  String? competenceName;
  String? industryRelevance;

  Competences({this.technology, this.competenceName, this.industryRelevance});

  Competences.fromJson(Map<String, dynamic> json) {
    technology = json['Technology'];
    competenceName = json['Competence_Name'];
    industryRelevance = json['Industry_Relevance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Technology'] = this.technology;
    data['Competence_Name'] = this.competenceName;
    data['Industry_Relevance'] = this.industryRelevance;
    return data;
  }
}