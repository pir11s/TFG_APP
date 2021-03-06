import 'dart:convert';

import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/UserKnowledgeModel.dart';
import 'package:app/models/json/CompetencesTechnologies.dart';
import 'package:app/models/json/EmployeesTechnologies.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/views/commonWidgets/MiniAvatar.dart';
import 'package:app/views/commonWidgets/SanChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TechnologyService {
  static Map<String, TechnologyModel> technologies = {};
  static Map<String, List<UserKnowledgeModel>> technologyKnowledges = {};
  static Map<String, List<TechnologyModel>> competenceTechnologies = {};
  TechnologyService._();

  static readData() async {
    final String response =
        await rootBundle.loadString('assets/json/CompetenceTechnologies.json');
    CompetencesTechnologies competencesTechnologies =
        CompetencesTechnologies.fromJson(jsonDecode(response));
    for (Competences c in competencesTechnologies.competences!) {
      TechnologyModel t = new TechnologyModel(
          competenceName: c.competenceName!,
          technologyName: c.technology!,
          industryRelevance: int.parse(
              c.industryRelevance != null ? c.industryRelevance! : "1"));

      technologies[c.technology!] = t;
      if (competenceTechnologies[c.competenceName!] == null) {
        competenceTechnologies[c.competenceName!] = [];
      }
      competenceTechnologies[c.competenceName]!.add(t);
    }
    final String responseKnowledge =
        await rootBundle.loadString('assets/json/EmployeesTech.json');
    EmployeesTechnologies employeesTechnologies =
        EmployeesTechnologies.fromJson(jsonDecode(responseKnowledge));
    for (EmployeeTechnology e in employeesTechnologies.employeesTechnologies!) {
      if (technologyKnowledges[e.technology!] == null) {
        technologyKnowledges[e.technology!] = [];
      }
      technologyKnowledges[e.technology!]!.add(new UserKnowledgeModel(
          competenceName: e.competenceName!,
          user: e.employeeName!,
          skillLevel: e.skillLevel!));
    }
  }

  

  static int getPeopleCountPerTechnology(String technology) {
    return technologyKnowledges[technology]!.length;
  }

  static bool isExpert(String technologyName, String user) {
    List<UserKnowledgeModel> usersKnowledge =
        technologyKnowledges[technologyName]!;
    for (UserKnowledgeModel u in usersKnowledge) {
      if (u.user == user) {
        return int.parse(u.skillLevel[0]) > 2 ? true : false;
      }
    }
    return false;
  }

  static double getAverageSkillOfTechnology(String technologyName) {
    double value = 0;
    for (UserKnowledgeModel u in technologyKnowledges[technologyName]!) {
      value += int.parse(u.skillLevel[0]);
    }
    return value / technologyKnowledges[technologyName]!.length;
  }

  static List<String> getTechnologiesNames() {
    List<String> names = [];
    technologies.forEach((key, value) {
      names.add(value.technologyName);
    });
    return names;
  }

  static TechnologyModel getTechnology(String tech) {
    return technologies[tech]!;
  }

  static List<Widget> getExperts(technologyName) {
    List<Widget> tagList = [];
    Set<String> users = {};

    for (UserKnowledgeModel u
        in TechnologyService.technologyKnowledges[technologyName]!) {
      if (TechnologyService.isExpert(technologyName, u.user) &&
          !users.contains(u.user)) {
        users.add(u.user);
        tagList.add(MiniAvatar(id: PeopleService.getEmployeeByName(u.user).id));
      }
    }

    return tagList;
  }

  static List<Widget> getPeopleWithKnowledge(String technologyName) {
    List<Widget> tagList = [];
    Set<String> users = {};
    for (UserKnowledgeModel u
        in TechnologyService.technologyKnowledges[technologyName]!) {
      if (!TechnologyService.isExpert(technologyName, u.user) &&
          !users.contains(u.user)) {
        users.add(u.user);
        tagList.add(MiniAvatar(id: PeopleService.getEmployeeByName(u.user).id));
      }
    }

    return tagList.toSet().toList();
  }

  static List<Widget> getTechnologyListChipsByCompetence(String competenceName,
      String defaultDropdownValue, BuildContext context) {
    List<Widget> tagList = [];
    if (competenceName != defaultDropdownValue) {
      List<TechnologyModel> technologies =
          TechnologyService.competenceTechnologies[competenceName]!;
      for (TechnologyModel t in technologies) {
        tagList.add(
          GestureDetector(
            child: Hero(
              tag: "technology-${t.technologyName}",
              child: Material(
                  color: Colors.transparent,
                  child: SanChip(label: t.technologyName)),
            ),
            onTap: () {
              NavigateService.navigateDetailTechnology(
                  t.technologyName, context);
            },
          ),
        );
      }
    } else {
      TechnologyService.technologies.forEach((key, value) {
        tagList.add(
          GestureDetector(
            child: Hero(
              tag: "technology-${value.technologyName}",
              child: Material(
                  color: Colors.transparent,
                  child: SanChip(label: value.technologyName)),
            ),
            onTap: () {
              NavigateService.navigateDetailTechnology(
                  value.technologyName, context);
            },
          ),
        );
      });
    }

    return tagList;
  }
}
