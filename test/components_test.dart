import 'package:app/models/CompetenceModel.dart';
import 'package:app/models/LoginModel.dart';
import 'package:app/models/PersonModel.dart';
import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/TechnologyUserModel.dart';
import 'package:app/models/UserKnowledgeModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Models Constructors', () {
    test('CompetenceModel Constructor', () {
      CompetenceModel competenceModel = new CompetenceModel(
          competenceName: "",
          competenceLeader: "",
          description: "",
          image: "",
          scope: "",
          premises: "",
          complianceImpacts: "",
          economicModel: "",
          standardSlas: "",
          technologiesSkillLevel: {},
          technologiesIndustryRelevance: {},
          members: {});
      // ignore: unnecessary_null_comparison
      expect(competenceModel != null, true);
    });

    test('LoginModel Constructor', () {
      LoginModel loginModel = new LoginModel(user: "", password: "");
      // ignore: unnecessary_null_comparison
      expect(loginModel != null, true);
    });

    test('PersonModel Constructor', () {
      PersonModel personModel = new PersonModel(
          user: "",
          displayName: "",
          jobTitle: "",
          mail: "",
          mobilePhone: "",
          officeLocation: "",
          prefferedLanguage: "",
          surname: "",
          userPrincipalName: "",
          id: "",
          competence: "",
          function: "",
          technologies: [],
          image: "",
          businessPhone: "");
      // ignore: unnecessary_null_comparison
      expect(personModel != null, true);
    });

    test('TechnologyModel Constructor', () {
      TechnologyModel technologyModel = new TechnologyModel(
          competenceName: "", technologyName: "", industryRelevance: 0);
      // ignore: unnecessary_null_comparison
      expect(technologyModel != null, true);
    });

    test('TechnologyUserModel Constructor', () {
      TechnologyUserModel technologyUserModel = new TechnologyUserModel(
          competenceName: "", technologyName: "", skillLevel: "");
      // ignore: unnecessary_null_comparison
      expect(technologyUserModel != null, true);
    });

    test('UserKnowledgeModel Constructor', () {
      UserKnowledgeModel userKnowledgeModel =
          new UserKnowledgeModel(competenceName: "", user: "", skillLevel: "");
      // ignore: unnecessary_null_comparison
      expect(userKnowledgeModel != null, true);
    });
  });
}
