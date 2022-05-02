
import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/json/CompetencesTechnologies.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:app/views/commonWidgets/SanChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  
  List<String> competencesList = [];
  String dropdownValue = defaultDropdownValue;
  @override
  void initState() {
    competencesList = TechnologyService.getCompetenceNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> technologyList(String competenceName) {
      List<Widget> tagList = [];
      List<TechnologyModel> technologies = TechnologyService.competenceTechnologies[competenceName]!;
      if (competenceName == defaultDropdownValue) {
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
                
              },
            ),
          );
         }
        
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