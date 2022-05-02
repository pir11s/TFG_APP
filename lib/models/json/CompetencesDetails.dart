class CompetencesDetails {
  List<CompetenceDetails>? competenceDetails;

  CompetencesDetails({this.competenceDetails});

  CompetencesDetails.fromJson(Map<String, dynamic> json) {
    if (json['competences'] != null) {
      competenceDetails = <CompetenceDetails>[];
      json['competences'].forEach((v) {
        competenceDetails!.add(new CompetenceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.competenceDetails != null) {
      data['competences'] = this.competenceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompetenceDetails {
  String? competenceName;
  String? description;
  String? image;
  String? scope;
  String? premises;
  String? complianceImpacts;
  String? economicModel;
  String? standardSLAs;

  CompetenceDetails(
      {this.competenceName,
      this.description,
      this.image,
      this.scope,
      this.premises,
      this.complianceImpacts,
      this.economicModel,
      this.standardSLAs});

  CompetenceDetails.fromJson(Map<String, dynamic> json) {
    competenceName = json['Competence_Name'];
    description = json['description'];
    image = json['image'];
    scope = json['scope'];
    premises = json['premises'];
    complianceImpacts = json['complianceImpacts'];
    economicModel = json['economicModel'];
    standardSLAs = json['standardSLAs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Competence_Name'] = this.competenceName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['scope'] = this.scope;
    data['premises'] = this.premises;
    data['complianceImpacts'] = this.complianceImpacts;
    data['economicModel'] = this.economicModel;
    data['standardSLAs'] = this.standardSLAs;
    return data;
  }
}