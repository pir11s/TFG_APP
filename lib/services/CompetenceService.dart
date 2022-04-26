import 'dart:convert';

import 'package:app/models/CompetenceModel.dart';
import 'package:app/models/json/CompetencesLeaders.dart';
import 'package:flutter/services.dart';

class CompetenceService {


  static Map<String,CompetenceModel> competences = {}; 

  CompetenceService._();

  static read_data() async {

      final String response = await rootBundle.loadString('assets/json/CompetenceLeaders.json');
      CompetencesLeaders competencesLeaders = CompetencesLeaders.fromJson(jsonDecode(response));
      for (CompetenceLeader c in competencesLeaders.leaders!) {
          competences[c.competenceName!] = new CompetenceModel(c.competenceName!, 
          c.employeeName!, [], []);
      }  
    
  }



}