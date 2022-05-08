
import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/UserKnowledgeModel.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:app/views/commonWidgets/MiniAvatar.dart';
import 'package:app/views/commonWidgets/SanChip.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';
import 'commonWidgets/PageContainer.dart';

const defaultDropdownValue = "Full CoE";


///Display of all technologies of CoE. All technologies are assigned to a competence. You can
///swap between competences to see all technologies related to each competence. If technology is clicked
///a TechnologyDetailPage is displayed.
class TechnologyView extends StatefulWidget {
  TechnologyView({Key? key}) : super(key: key);

  @override
  _TechnologiesViewState createState() => _TechnologiesViewState();
}

class _TechnologiesViewState extends State<TechnologyView> {
  
  List<String> competencesList = [defaultDropdownValue];
  String dropdownValue = defaultDropdownValue;
  @override
  void initState() {
    competencesList.addAll(TechnologyService.getCompetenceNames());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> technologyList(String competenceName) {
      List<Widget> tagList = [];
      if (competenceName != defaultDropdownValue) {
         List<TechnologyModel> technologies = TechnologyService.competenceTechnologies[competenceName]!;
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
                NavigateService.navigateDetailTechnology(t.technologyName, context);
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
                NavigateService.navigateDetailTechnology(value.technologyName, context);
              },
            ),
          );
        });
      }

      return tagList;
    }

    return Scaffold(
      body: PageContainer(
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Competence: ", style: AppText.moduleTitle),
                DropdownButton(
                  value: dropdownValue,
                  style: AppText.moduleLinkTitle,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue.toString();
                    });
                  },
                  items: competencesList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Wrap(
                    spacing: 5,
                    runAlignment: WrapAlignment.center,
                    runSpacing: -5,
                    children: technologyList(dropdownValue),
                  ),
                  SizedBox(
                    height: 25.0,
                    width: 150.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TechnologyDetailView extends StatelessWidget {
  final String technologyName;

  TechnologyDetailView({required this.technologyName});

  List<Widget> peopleList(String technologyName, bool experts) {
    List<Widget> tagList = [];

    for (UserKnowledgeModel u in TechnologyService.technologyKnowledges[technologyName]!) {
        if (TechnologyService.isExpert(technologyName, u.user)) {
          tagList.add(MiniAvatar(id: PeopleService.getEmployeeByName(u.user).id));
        } else if (!experts) {
          tagList.add(MiniAvatar(id: PeopleService.getEmployeeByName(u.user).id));
        }
    }

    return tagList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mainExperts = peopleList(technologyName, true);
    List<Widget> otherExperts = peopleList(technologyName, false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageContainer(
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                      width: 150.0,
                    ),
                    Hero(
                        tag: 'technology-$technologyName',
                        child: Material(
                          child: Chip(
                            label: Text(
                              technologyName,
                              style: AppText.sectionTitle.copyWith(
                                  color: AppColors.color12, fontSize: 24),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 10,
                            shadowColor: Colors.grey[60],
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                      width: 150.0,
                    ),
                    Text(
                      "${TechnologyService.getPeopleCountPerTechnology(technologyName)} CoE members with skills",
                      style: AppText.bodyTitle,
                    ),
                    mainExperts.length > 0
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: Text(
                              'MAIN EXPERTS',
                              textAlign: TextAlign.center,
                              style: AppText.bodyOutstandingText
                                  .copyWith(color: Colors.black),
                            ),
                          )
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                    mainExperts.length > 0
                        ? SizedBox(
                            height: 10.0,
                            width: 150.0,
                          )
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                    mainExperts.length > 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                Wrap(
                                  spacing: 5,
                                  runAlignment: WrapAlignment.center,
                                  runSpacing: -5,
                                  children: mainExperts,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    otherExperts.length > 0
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: Text(
                              'MEMBERS WITH KNOWLEDGE',
                              textAlign: TextAlign.center,
                              style: AppText.bodyOutstandingText
                                  .copyWith(color: Colors.black),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    SizedBox(
                      height: 10.0,
                      width: 150.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 5,
                            runAlignment: WrapAlignment.center,
                            runSpacing: -5,
                            children: otherExperts,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}