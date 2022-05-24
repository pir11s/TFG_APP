
import 'package:app/models/PersonModel.dart';
import 'package:app/services/CompetenceService.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/views/commonWidgets/Buttons.dart';
import 'package:app/views/commonWidgets/MiniAvatar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';
import 'package:url_launcher/url_launcher.dart';

import 'commonWidgets/PageContainer.dart';


///List of CoE competences. Each competences has a title and related text, plus an image to describe
///the competence. If any competence is clicked a CompetenceDetail widget is displayed.
class CompetencesView extends StatefulWidget {
  @override
  _CompetencesState createState() => _CompetencesState();
}

class _CompetencesState extends State<CompetencesView> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        
          child: ListView.separated(
            separatorBuilder: (content, index) {
              return Divider(
                height: 25,
              );
            },
            itemCount: CompetenceService.getCompetences().length,
            itemBuilder: (context, index) {
              String key = CompetenceService.getCompetences().keys.elementAt(index);
              double sizedBoxFirst = 0;
              sizedBoxFirst = index == 0 ?  15 : 0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox( height: sizedBoxFirst,),
                  Material(
                    color: Colors.transparent,
                    child: MaterialButton(
                      onPressed: () {
                        NavigateService.navigateDetailCompetence(key, context);
                      },
                      child: Row(
                        children: [
                          competenceImage(key),
                          Expanded(
                            child: SizedBox(),
                            flex: 1,
                          ),
                          competenceText(key),
                          Expanded(
                            child: SizedBox(),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      
    );
  }

  Expanded competenceImage(String key) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: (key == "")
              ? const EdgeInsets.only(top: 15.0)
              : const EdgeInsets.only(),
          child: Hero(
            tag: 'CompetenceImageDetail' + CompetenceService.getCompetences()[key]!.competenceName,
            child: Image(
              image: ResizeImage(AssetImage(CompetenceService.getCompetences()[key]!.image),
                  width: 200, height: 150),
            ),
          ),
        ));
  }

   Expanded competenceText(String key) {
    return Expanded(
      flex: 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              CompetenceService.getCompetences()[key]!.competenceName,
              style: TextStyle(fontSize: 24, color: AppColors.color12),
            ),
          ),
          ExpandableText(
             CompetenceService.getCompetences()[key]!.description,
            textAlign: TextAlign.justify,
            expandText: 'show more',
            collapseText: 'show less',
            animation: true,
            animationDuration: Duration(milliseconds: 700),
            maxLines: 4,
            linkColor: AppColors.color12,
          )
        ],
      ),
    );
  }
}


class CompetenceDetailView extends StatefulWidget {
  final String competenceName;

  CompetenceDetailView({required this.competenceName});

  _CompetenceDetailViewState createState() => _CompetenceDetailViewState();
}

class _CompetenceDetailViewState extends State<CompetenceDetailView> {
  // ignore: unused_field
  int _selectedIndex = 0;
  Widget? info;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.competenceName, style: AppText.appBar),
        backgroundColor: AppColors.color4,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Hero(
                tag: 'CompetenceImageDetail' + widget.competenceName,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.topCenter,
                        image: AssetImage(CompetenceService.getCompetenceImage(widget.competenceName))),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: PageView(
                      children: [
                        Inform(
                          competenceName: widget.competenceName,
                        ),
                        
                      ],
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}

class Inform extends StatefulWidget {
  final String competenceName;

  Inform({required this.competenceName});
  @override
  _InformState createState() => _InformState();
}

class _InformState extends State<Inform> {
  
  Text titleSection(text) {
    return Text(
      text,
      style: TextStyle(color: AppColors.color12, fontSize: 20),
      textAlign: TextAlign.left,
    );
  }

  Text textSection(BuildContext context, text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  void _launchURL(String url) async =>
      await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';

  List<Widget> getContactMethods(String personName) {
    PersonModel person = PeopleService.getEmployeeByName(personName);

    List<Widget> contactMethods = [];
    
    contactMethods.add(Expanded(child: MiniAvatar(id: person.id)));

    if (person.mobilePhone != "" && person.mobilePhone != '') {
      contactMethods.add(SignInButton.nano(
          buttonType: ButtonType.call,
          btnColor: Colors.green,
          buttonSize: ButtonSize.nano,
          onPressed: () {
            _launchURL("tel:${person.mobilePhone}");
          }));
    }

    if (person.mail != "" && person.mail != '') {
      contactMethods.add(Expanded(
        child: SignInButton.nano(
            buttonType: ButtonType.mail,
            onPressed: () {
              launchUrl(Uri.parse("mailto:${person.mail}"));
            }),
      ));

      contactMethods.add(Expanded(
        child: SignInButton.nano(
            buttonType: ButtonType.microsoftTeams,
            onPressed: () {
              launchUrl(
                  Uri.parse("msteams://teams.microsoft.com/l/chat/0/0?users=${person.mail}"));
            }),
      ));
    }

    return contactMethods;
  }

  List<Widget> peopleList(String competenceName) {
    List<Widget> tagList = [];
    String competenceLeader = CompetenceService.getCompetenceLeader(competenceName);
    List<String> usersNames = CompetenceService.getEmployeesOfCompetence(competenceName);
    for (String name in usersNames) {
      if ( competenceLeader != name) {
        tagList.add(MiniAvatar(id: PeopleService.getEmployeeByName(name).id));
      }
    }

    return tagList;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Text(
                  'COMPETENCE LEADER',
                  textAlign: TextAlign.center,
                  style: AppText.bodyOutstandingText
                      .copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getContactMethods(
                          CompetenceService.getCompetenceLeader(widget.competenceName),
                    ),
                  )
                  )],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Text(
                  'COMPETENCE MEMBERS',
                  textAlign: TextAlign.center,
                  style: AppText.bodyOutstandingText
                      .copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 0,
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Wrap(
                    children: peopleList(widget.competenceName),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );

  }
}