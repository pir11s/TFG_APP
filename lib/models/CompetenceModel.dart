import 'package:app/models/PersonModel.dart';
import 'package:app/models/TechnologyModel.dart';

class CompetenceModel {

  String competenceName = '', 
  competenceLeader = '';
  String description;
  String image;
  String scope;
  String premises;
  String complianceImpacts;
  String economicModel;
  String standardSlas;
  Map<String,String> technologiesSkillLevel;
  Map<String,String> technologiesIndustryRelevance;
  Map<String,String> members;

  CompetenceModel({required this.competenceName, required this.competenceLeader,required this.description,
    required this.image,required this.scope,
    required this.premises,required this.complianceImpacts,required this.economicModel,required this.standardSlas,
    required this.technologiesSkillLevel,required this.technologiesIndustryRelevance, required this.members});

}