import 'package:app/models/PersonModel.dart';
import 'package:app/services/PeopleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

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
                   
                  });
            },
            itemCount: _peopleShown.length,
          ),
        ),
      ],
    );
  }

}