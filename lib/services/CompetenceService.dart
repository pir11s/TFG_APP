import 'dart:convert';

import 'package:app/models/CompetenceModel.dart';
import 'package:app/models/json/CompetencesDetails.dart';
import 'package:app/models/json/CompetencesLeaders.dart';
import 'package:app/models/json/CompetencesTechnologies.dart';
import 'package:app/models/json/EmployeesTechnologies.dart';
import 'package:flutter/services.dart';

class CompetenceService {


  static Map<String,CompetenceModel> competences = {}; 

  CompetenceService._();

  static readData() async {

      final String responseLeaders = await rootBundle.loadString('assets/json/CompetenceLeaders.json');
      CompetencesLeaders competencesLeaders = CompetencesLeaders.fromJson(jsonDecode(responseLeaders));
      for (CompetenceLeader c in competencesLeaders.leaders!) {
          
          competences[c.competenceName!] = new CompetenceModel(
            competenceName: c.competenceName!, 
            competenceLeader: c.employeeName!, 
            description: "", 
            image: "", 
            scope: "", 
            premises: "", 
            complianceImpacts: "", 
            economicModel: "", 
            standardSlas: "", 
            technologiesSkillLevel: {}, 
            technologiesIndustryRelevance: {},
            members: {});
      }  
      final String responseDetails = await rootBundle.loadString('assets/json/CompetenceDetails.json');
      CompetencesDetails competencesDetails = CompetencesDetails.fromJson(jsonDecode(responseDetails));
      for (CompetenceDetails c in competencesDetails.competenceDetails!) {
          competences[c.competenceName]?.description = c.description!;
          competences[c.competenceName]?.complianceImpacts = c.complianceImpacts!;
          competences[c.competenceName]?.image = c.image!;
          competences[c.competenceName]?.economicModel = c.economicModel!;
          competences[c.competenceName]?.scope = c.scope!;
          competences[c.competenceName]?.premises = c.premises!;
          competences[c.competenceName]?.standardSlas = c.standardSLAs!;
      }
      final String responseTechnologies = await rootBundle.loadString('assets/json/EmployeesTech.json');
      EmployeesTechnologies employeesTechnologies = EmployeesTechnologies.fromJson(jsonDecode(responseTechnologies));
       for (EmployeeTechnology e in employeesTechnologies.employeesTechnologies!) {
          competences[e.competenceName]!.members[e.employeeName!] = e.employeeName!.toUpperCase();
           competences[e.competenceName]!.technologiesSkillLevel[e.technology!] = e.skillLevel!;
    }

    final String responseIndustryRelevance = await rootBundle.loadString('assets/json/CompetenceTechnologies.json');
      CompetencesTechnologies competencesTechnologies = CompetencesTechnologies.fromJson(jsonDecode(responseIndustryRelevance));
    for (Competences e in competencesTechnologies.competences!) {
          competences[e.competenceName]!.technologiesIndustryRelevance[e.technology!] = e.industryRelevance != null ? e.industryRelevance! : "1";
    }
  }

  static List<String> getCompetenceNames() {
    List<String> competencesNames = [];
     competences.forEach((key, value) {
       competencesNames.add(value.competenceName);
     });
     return competencesNames;
  }

  static Map<String,CompetenceModel> getCompetences(){
    return competences;
  }

  static String getCompetenceImage(String competenceName) {
    return competences[competenceName]!.image;
  }

  static List<String> getEmployeesOfCompetence(String competence) {
    List<String> memberNames = [];
    competences[competence]!.members.forEach((key, value) {
      memberNames.add(value);
    });
    return memberNames;
  }

  static String getCompetenceLeader(String competenceName) {
    return competences[competenceName]!.competenceLeader;
  }

  static double getAverageSkillPerCompetence (String competenceName) {
    double sum = 0;
    double length = 0;
    competences[competenceName]!.technologiesSkillLevel.forEach((key, value) {
      sum += int.parse(value[0]);
      length += 1;
    });
    return sum / length;
  }

  static double getAverageIndustryRelevancePerCompetence(String competence) {
     double sum = 0;
    double length = 0;
    competences[competence]!.technologiesIndustryRelevance.forEach((key, value) {
      sum += int.parse(value);
      length += 1;
    });
    return length == 0 ? 1 : sum / length;
  }

  static int getNumberOfMembersCompetence(String competence) {
    return competences[competence]!.members.length;
  }

  static int getTechnologyCountPerCompetence(competenceName) {
    return competences[competenceName]!.technologiesIndustryRelevance.length;
  }

}