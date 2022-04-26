import 'package:app/models/PersonModel.dart';
import 'package:app/models/TechnologyModel.dart';

class CompetenceModel {

  String competenceName = '', competenceLeader = '';
  List<TechnologyModel> technologies;
  List<PersonModel> members;

  CompetenceModel(this.competenceName, this.competenceLeader,this.technologies,this.members);

}