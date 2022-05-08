import 'package:app/models/PersonModel.dart';
import 'package:app/models/TechnologyUserModel.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/views/commonWidgets/Buttons.dart';
import 'package:app/views/commonWidgets/PageContainer.dart';
import 'package:app/views/commonWidgets/SanChip.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';
import 'package:url_launcher/url_launcher.dart';

import 'commonWidgets/SearchWidget.dart';

///List of all members of CoE. Displays a search bar for users and a scrollable
///list of all employees. If employee is clicked a PersonDetail widget is displayed.
class PeopleView extends StatefulWidget {
  @override
  _PeopleViewState createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {


  List<PersonModel> _peopleShown = PeopleService.people;
  String _searchText = '';

  _peopleSort(String search) {
    final peopleNew = PeopleService.people.where((person) {
      final nameLower = person.displayName.toLowerCase();
      final userLower = person.id.toLowerCase();
      final searchLower = search.toLowerCase();

      return nameLower.contains(searchLower) || userLower.contains(searchLower);
    }).toList();
    setState(() {
      _searchText = search;
      _peopleShown = peopleNew;
      print(PeopleService.people.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: SearchWidget(
              text: _searchText, onChanged: _peopleSort, hintText: 'Search'),
        ),
        SizedBox(height: 10),
        Expanded(
          flex: 10,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_peopleShown[index].displayName,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  subtitle: Text(_peopleShown[index].competence,
                      style: AppText.moduleLinkTitle),
                  leading: Hero(
                    tag: 'avatar-${PeopleService.people[index].id}',
                    child: Container(
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  PeopleService.getAvatar(_peopleShown[index].id),
                            ),
                          ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    NavigateService.navigateDetailEmployee(_peopleShown[index].id, context);
                  });
            },
            itemCount: _peopleShown.length,
          ),
        ),
      ],
    );
  }
}

class PersonDetailView extends StatelessWidget {
  final String id;

  PersonDetailView({required this.id});

  @override
  Widget build(BuildContext context) {
    PersonModel person = PeopleService.getEmployeeById(id);

    List<Widget> technologyList(String id) {
      List<Widget> tagList = [];

      for (TechnologyUserModel t in person.technologies) {
        
          tagList.add(GestureDetector(
            onTap: () {
              NavigateService.navigateDetailTechnology(t.technologyName, context);
            },
            child: Hero(
              tag: "technology-${t.technologyName}",
              child: Material(
                color: Color(0x00000000),
                child: SanChip(
                    label: t.technologyName,
                    highlight: int.parse(t.skillLevel[0]) > 2),
              ),
            ),
          ));
        
      }

      return tagList;
    }

    List<Widget> technologiesList = technologyList(id);

    List<Widget> _buildContactMethods() {
      List<Widget> contactMethods = [];

      if (person.mobilePhone != "") {
      contactMethods.add(SignInButton.mini(
          buttonType: ButtonType.call,
          btnColor: Colors.green,
          buttonSize: ButtonSize.small,
          onPressed: () {
            _launchURL("tel:${person.mobilePhone}");
          }));
    }

    if (person.mail != "") {
      contactMethods.add(SignInButton.mini(
          buttonType: ButtonType.mail,
          buttonSize: ButtonSize.small,
          onPressed: () {
            launchUrl(Uri.parse("mailto:${person.mail}"));
          }));

      contactMethods.add(SignInButton.mini(
          buttonType: ButtonType.microsoftTeams,
          buttonSize: ButtonSize.small,
          onPressed: () {
            launchUrl(
                Uri.parse("msteams://teams.microsoft.com/l/chat/0/0?users=${person.mail}"));
          }));
    }

      return contactMethods;
    }

    return PageContainer(
      child: ListView(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                  width: 150.0,
                ),
                Hero(
      tag: 'avatar-$id',
      child: PeopleService.hasImageById(id)
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      color: AppColors.color6,
                      spreadRadius: 10)
                ],
              ),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: AppColors.color6,
                backgroundImage: PeopleService.getAvatar(id),
              ),
            )
          : Container(
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                backgroundImage: PeopleService.getAvatar(id),
              ),
            ),
      ),
                SizedBox(
                  height: 10.0,
                  width: 150.0,
                ),
               Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        child: ListTile(
          title: Column(
            children: [
              Text(
                person.surname,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(
                person.competence,
                style: AppText.moduleLinkTitle,
              ),
              Text(
                person.function,
                style: AppText.moduleTitle,
              ),
              (person.officeLocation != "" &&
                      person.officeLocation != '')
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: AppColors.color12,
                        ),
                        SizedBox(width: 5),
                        Text(person.officeLocation,
                            textAlign: TextAlign.center,
                            style: AppText.bodyText),
                        SizedBox(width: 10),
                      ],
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildContactMethods(),
              ),
              SizedBox(height: 5),
            ],
          ),
        )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 5,
                        runAlignment: WrapAlignment.center,
                        runSpacing: -5,
                        children: technologiesList,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async =>
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
}

