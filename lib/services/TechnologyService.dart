import 'dart:convert';

import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/json/CompetencesTechnologies.dart';
import 'package:flutter/services.dart';

class TechnologyService {

  static Map<String,TechnologyModel> technologies = {};
  static Map<String, List<TechnologyModel>> competenceTechnologies = {};
  TechnologyService._();

   static read_data() async {

       final String response = await rootBundle.loadString('assets/json/CompetenceTechnologies.json');
        CompetencesTechnologies competencesTechnologies = CompetencesTechnologies.fromJson(jsonDecode(response));
        for (Competences c in competencesTechnologies.competences!) {
          TechnologyModel t = new TechnologyModel(
              c.competenceName!, c.technology!,
              int.parse(c.industryRelevance != null ? c.industryRelevance! : "1")
              );
          technologies[c.technology!] = t;
          competenceTechnologies[c.competenceName!]!.add(t);
        }

  }

}