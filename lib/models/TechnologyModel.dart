

/// Technology.
///
/// Atributes:
///
///  - String name: technology name
///  - String competence: competence name
///  - Int industry relevance: relevance in industry
class TechnologyModel {
  String competenceName = '', technologyName = '';
  int industryRelevance =1;

  TechnologyModel({required this.competenceName,required this.technologyName,required this.industryRelevance});
  
}