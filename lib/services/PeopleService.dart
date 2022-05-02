import 'dart:convert';

import 'package:app/models/json/Details.dart';
import 'package:app/models/json/Employees.dart';
import 'package:app/models/json/EmployeesImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/PersonModel.dart';

class PeopleService {

  PeopleService._();

  static List<PersonModel> people = [];
  static Map <String,PersonModel> _mapEmployees = {};

  static read_data() async {
    final String responseEmployees = await rootBundle.loadString('assets/json/Employees.json');
    Employees employees = Employees.fromJson(jsonDecode(responseEmployees));
    Map <String,PersonModel> mapEmployees = {};
    for (Employee e in employees.employees!) {
      PersonModel p = new PersonModel(
        user: e.name!, 
        displayName: "", 
        jobTitle: "", 
        mail: "", 
        mobilePhone: "", 
        officeLocation: "", 
        prefferedLanguage: "", 
        surname: "", 
        userPrincipalName: "", 
        id: e.id!, competence: e.competence!, 
        function: e.groupFunction!, technologies: [], 
        image: "", businessPhone: "");
      _mapEmployees[p.id] = p;
    }
    final String responseDetails = await rootBundle.loadString('assets/json/Details.json');
    Details details = Details.fromJson(jsonDecode(responseDetails));
    Pattern mail = RegExp("@");
    for (EmployeeDetail e in details.employeesDetails!) {
      print(
          e.userPrincipalName!.split(mail)[0]);
        PersonModel p = _mapEmployees[
          e.userPrincipalName!.split(mail)[0]
          ]!;
        p.displayName = e.displayName!;
        p.jobTitle = e.jobTitle!;
        p.mail = e.mail!; 
        p.mobilePhone = e.mobilePhone!; 
        p.officeLocation = e.officeLocation!; 
        p.prefferedLanguage = e.preferredLanguage == null ? "" : e.preferredLanguage!; 
        p.surname = e.surname!;
        p.userPrincipalName = e.userPrincipalName!; 
    }
     final String responseImage = await rootBundle.loadString('assets/json/EmployeesImg.json');
    EmployeesImages employeesImages = EmployeesImages.fromJson(jsonDecode(responseImage));
    for (EmployeeImage e in employeesImages.employeesImages!) {
        PersonModel p = _mapEmployees[e.id]!;
        p.image = e.image!;
        people.add(p);
        
    }
    print(people.length);
  }

  static PersonModel getEmployeeById(String id) {
    return _mapEmployees[id]!;
  }

  static bool _hasImage(PersonModel e) {
    return e.image == "YES";
  }

  static bool _hasImageById(String id) {
    return _mapEmployees[id]!.image == "YES";
  }

  static AssetImage getAvatar(String id) {
    AssetImage avatar;
    PersonModel e = _mapEmployees[id]!;

    if (_hasImage(e)) {
      String id = e.id;
      avatar = AssetImage(
        'images/people/$id.jpg',
      );
    } else {
      avatar = AssetImage(
        'images/people/no_avatar.png',
      );
    }
    return avatar;
  }


}