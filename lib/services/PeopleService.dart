import 'dart:convert';

import 'package:app/models/json/Employees.dart';
import 'package:flutter/cupertino.dart';

import '../models/PersonModel.dart';

class PeopleService {

  PeopleService._();

  static List<PersonModel> people = [];

  static void read_data(context) async {
      final json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/json/generatedEmployees.json"));

    for (var jsonUser in json['employees']) {
      Employee employee = Employee.fromJson(jsonUser);
      
    }

  }


}