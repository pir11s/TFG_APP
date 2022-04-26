import 'dart:convert';

import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/json/CompetencesTechnologies.dart';
import 'package:flutter/services.dart';

class TechnologyService {

  static Map<String,TechnologyModel> technologies = {};
  
  TechnologyService._();

   static read_data() async {

       final String response = await rootBundle.loadString('assets/json/CompetenceTechnologies.json');
        CompetencesTechnologies competencesTechnologies = CompetencesTechnologies.fromJson(jsonDecode(response));
        var numberOfElements = competencesTechnologies.competences!.length;

        for (var i = 0; i < numberOfElements; i++) {
          var aux = competencesTechnologies.competences![i];
          technologies[aux.technology!] =
            new TechnologyModel(
              aux.competenceName!, aux.technology!,
              int.parse(aux.industryRelevance != null ? aux.industryRelevance! : "1")
              )
            ;     
        }

  }

}