
import 'package:app/services/CompetenceService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';


const graphColors = [
  AppColors.color5,
  AppColors.color6,
  AppColors.color13,
  AppColors.color18,
];

double numberOfFeatures = 6;

List<String> competencesList = ["Full CoE"];
List<String> competencesWithTechnologiesList = ["Full CoE"];

const defaultDropdownValue = "Full CoE";
String dropdownValue = defaultDropdownValue;
bool showIndustryRelevance = false;
bool showHeadCount = false;

///Information about each Competence in CoE. Displays a different rounded graph
///for each competence. It has a button to show industry relevance of selected competence
///in mentioned graph.
class KPIsView extends StatefulWidget {
  KPIsView({Key? key}) : super(key: key);

  @override
  _KPIsViewState createState() => _KPIsViewState();
}

class _KPIsViewState extends State<KPIsView> {
  bool darkMode = false;

  double maxNumberOfFeatures = 7;

  @override
  void initState() {
    if (competencesList.length == 1) {
      for (String competence in CompetenceService.getCompetenceNames()) {
        competencesList.add(competence);
        if (CompetenceService.getTechnologyCountPerCompetence(competence) >
            1) {
          competencesWithTechnologiesList.add(competence);
        }
      }
    }

    super.initState();
  }

  bool _isPortraitOrientation() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return ((currentOrientation == Orientation.portrait) || kIsWeb);
  }

  @override
  Widget build(BuildContext context) {
    const ticks = [50, 150, 250, 350,400];
    List<String> features = [];
    List<int> mainValues = [];
    List<int> secondaryValues = [];
    List<int> tertiaryValues = [];

  

    if (dropdownValue == defaultDropdownValue) {
      for (String competence in CompetenceService.getCompetenceNames()) {
         features.add(competence);
  
         mainValues.add((CompetenceService.getAverageSkillPerCompetence(competence) 
           * 100).round());
        secondaryValues.add((CompetenceService.getAverageIndustryRelevancePerCompetence(competence).toInt()*
                    100.round()));
        tertiaryValues.add((CompetenceService.getNumberOfMembersCompetence(competence)
                      ~/ PeopleService.getNumberOfEmployees()) * 600);
      }
    } else {
      for (String tech in TechnologyService.getTechnologiesNames()) {
        if (TechnologyService.getTechnology(tech).competenceName == dropdownValue
        && TechnologyService.getPeopleCountPerTechnology(tech) > 0) {
          features.add(tech);
          mainValues.add((TechnologyService.getAverageSkillForTechnology(
                      tech) *
                  100)
              .round());
          secondaryValues.add(TechnologyService.getTechnology(tech).industryRelevance * 75);
          tertiaryValues.add((TechnologyService.getPeopleCountPerTechnology(tech) 
          / PeopleService.getNumberOfEmployees()*500).toInt());
        }
      }
    }

    numberOfFeatures = features.length.toDouble();

    var data = [mainValues];
    if (showIndustryRelevance) {
      data.add(secondaryValues);
    }
    if (showHeadCount) {
      data.add(tertiaryValues);
    }

    features = features.sublist(0, numberOfFeatures.floor());
    data = data
        .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
        .toList();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _isPortraitOrientation()
              ? Expanded(
                  flex: 1,
                  child: Center(
                      child: Text("Average Knowledge",
                          style: AppText.headerTitle)),
                )
              : SizedBox(
                  height: 0,
                ),
          _isPortraitOrientation()
              ? Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Competence: ", style: AppText.moduleTitle),
                      DropdownButton(
                        value: dropdownValue,
                        style: AppText.moduleLinkTitle,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue.toString();
                            if (numberOfFeatures < 8) {
                              numberOfFeatures = 7;
                            }
                          });
                        },
                        items: competencesWithTechnologiesList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RadarChart(
                featuresTextStyle: TextStyle(
                    fontSize: 16,
                    height: 1,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic,
                    color: AppColors.color3,
                    ),
                ticks: ticks,
                features: features,
                data: data,
                graphColors: graphColors,
              ),
            ),
          ),
          _isPortraitOrientation()
              ? Expanded(
                  flex: 1,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: showIndustryRelevance,
                            onChanged: (_) {
                              setState(() {
                                showIndustryRelevance = !showIndustryRelevance;
                              });
                            }),
                        Text(
                          'Show Industry Relevance',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ]),
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}