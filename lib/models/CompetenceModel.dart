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
  List<TechnologyModel> technologies;
  List<PersonModel> members;

  CompetenceModel(this.competenceName, this.competenceLeader,this.description,
    this.image,this.scope,
    this.premises,this.complianceImpacts,this.economicModel,this.standardSlas,
    this.technologies,this.members);

}