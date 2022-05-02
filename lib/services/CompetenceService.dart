import 'dart:convert';

import 'package:app/models/CompetenceModel.dart';
import 'package:app/models/json/CompetencesDetails.dart';
import 'package:app/models/json/CompetencesLeaders.dart';
import 'package:flutter/services.dart';

class CompetenceService {


  static Map<String,CompetenceModel> competences = {}; 

  CompetenceService._();

  static read_data() async {

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
            technologies: [], 
            members: []);
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
  }

  static List<String> getCompetenceNames() {
    List<String> competencesNames = [];
     competences.forEach((key, value) {
       competencesNames.add(value.competenceName);
     });
     return competencesNames;
  }



}