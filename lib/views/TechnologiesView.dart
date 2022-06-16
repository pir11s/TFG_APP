import 'package:app/services/CompetenceService.dart';
import 'package:app/services/TechnologyService.dart';
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
    competencesList.addAll(CompetenceService.getCompetenceNames());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    children:
                        TechnologyService.getTechnologyListChipsByCompetence(
                            dropdownValue, defaultDropdownValue, context),
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

  @override
  Widget build(BuildContext context) {
    List<Widget> mainExperts = TechnologyService.getExperts(technologyName);
    List<Widget> otherExperts =
        TechnologyService.getPeopleWithKnowledge(technologyName);

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
