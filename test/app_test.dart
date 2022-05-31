import 'package:app/services/CompetenceService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:app/views/CompetencesView.dart';
import 'package:app/views/KPIsView.dart';
import 'package:app/views/LoginView.dart';
import 'package:app/views/PeopleView.dart';
import 'package:app/views/TechnologiesView.dart';
import 'package:app/views/commonWidgets/SearchWidget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/CompetenceModel.dart';
import 'package:app/models/LoginModel.dart';
import 'package:app/models/PersonModel.dart';
import 'package:app/models/TechnologyModel.dart';
import 'package:app/models/TechnologyCompetenceModel.dart';
import 'package:app/models/UserKnowledgeModel.dart';
import 'package:app/services/LoginService.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
      TechnologyCompetenceModel technologyUserModel =
          new TechnologyCompetenceModel(
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

  group('LoginService', () {
    test('get saved user', () async {
      Map<String, Object> values = <String, Object>{
        'userName': 'n12345',
        'password': '123'
      };
      SharedPreferences.setMockInitialValues(values);
      await LoginService.getUser();
      await LoginService.getPassword();
      expect(LoginService.user.user == 'n12345', true);
      expect(LoginService.user.password == '123', true);
    });

    test('delete saved user', () async {
      Map<String, Object> values = <String, Object>{
        'userName': 'n12345',
        'password': '123'
      };
      SharedPreferences.setMockInitialValues(values);
      await LoginService.deleteUser();
      expect(LoginService.user.user == '', true);
      expect(LoginService.user.password == '', true);
    });

    test('default values', () {
      expect(LoginService.user.user == '', true);
      expect(LoginService.user.password == '', true);
      expect(LoginService.hidePassword, true);
    });

    test('change hide password', () {
      bool actualPassword = LoginService.getHidePassword();
      LoginService.changeHide();
      expect(actualPassword != LoginService.getHidePassword(), true);
    });

    test('change remember me', () {
      bool rememberMe = LoginService.getRememberMe();
      LoginService.changeRemember();
      expect(rememberMe != LoginService.getRememberMe(), true);
    });
  });

  group('PersonService', () {
    test('read data', () async {
      await PeopleService.readData();
      expect(PeopleService.getNumberOfEmployees() == 85, true);
    });
    test('build contact methods', () async {
      await PeopleService.readData();
      PersonModel p = PeopleService.getEmployeeById('n802418');
      List<Widget> widgets = PeopleService.buildContactMethods(p);
      expect(widgets.length > 0, true);
    });

    test('get Avatar', () async {
      await PeopleService.readData();
      AssetImage a = new AssetImage('images/people/n802418.jpg');
      expect(PeopleService.getAvatar('n802418') == a, true);
    });

    test('has image', () async {
      await PeopleService.readData();
      expect(PeopleService.hasImageById('n802418') == true, true);
    });
  });

  group('TechnologyService', () {
    test('read data', () async {
      await TechnologyService.readData();
      expect(TechnologyService.getTechnologiesNames().length == 53, true);
    });

    test('is Expert', () async {
      await TechnologyService.readData();
      expect(TechnologyService.isExpert('Tech. Lead', 'Lylah Hester'), true);
    });

    test('not Expert', () async {
      await TechnologyService.readData();
      expect(TechnologyService.isExpert('Banksphere', 'Beverly Harvey'), false);
    });

    test('get Experts', () async {
      await PeopleService.readData();
      await TechnologyService.readData();
      expect(TechnologyService.getExperts('Banksphere').length > 0, true);
    });

    test('get Average Skill Of Tech', () async {
      await TechnologyService.readData();
      expect(TechnologyService.getAverageSkillOfTechnology('Tech. Lead') > 0,
          true);
    });

    test('get People Count Per Technology', () async {
      await TechnologyService.readData();
      expect(TechnologyService.getPeopleCountPerTechnology('Tech. Lead') > 0,
          true);
    });
  });

  group('CompetenceService', () {
    test('read data', () async {
      await CompetenceService.readData();
      expect(CompetenceService.getCompetenceNames().length == 7, true);
    });

    test('get Competences', () async {
      await CompetenceService.readData();
      expect(CompetenceService.getCompetences().length == 7, true);
    });

    test('get competence Image', () async {
      await CompetenceService.readData();
      expect(CompetenceService.getCompetenceImage('GOVERNANCE') != '', true);
    });

    test('get competence Employees', () async {
      await CompetenceService.readData();
      expect(
          CompetenceService.getEmployeesOfCompetence('GOVERNANCE').length > 0,
          true);
    });

    test('get Technology Count Per Competence', () async {
      await CompetenceService.readData();
      expect(
          CompetenceService.getTechnologyCountPerCompetence('GOVERNANCE') > 0,
          true);
    });
  });

  group('Login View', () {
    testWidgets('Settle credentials and log in', (tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginView()));
      await tester.pumpWidget(testWidget);
      await tester.enterText(find.byType(TextField).at(0), 'n12345');
      await tester.enterText(find.byType(TextField).at(1), '123');
      await tester.tap(find.byType(MaterialButton));
      await tester.pumpAndSettle();
      final findLoginView = find.byWidget(LoginView());
      expect(findLoginView, findsNothing);
    });

    testWidgets('creation', (tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginView()));
      await tester.pumpWidget(testWidget);
      final titleFinder = find.text('CoE Full Stack');
      final userFinder = find.text('User');
      final passwordFinder = find.text('Password');
      expect(titleFinder, findsOneWidget);
      expect(userFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
    });

    testWidgets('try to log without credentials settled', (tester) async {
      await tester.runAsync(() async {
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new LoginView()));
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(MaterialButton));
        await tester.pump();
        final noUser = find.text('Please enter your password');
        final noPassword = find.text('Please enter your password');
        expect(noUser, findsOneWidget);
        expect(noPassword, findsOneWidget);
      });
    });
  });

  group('People View', () {
    testWidgets('creation', (tester) async {
      await tester.runAsync(() async {
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: PeopleView(),
            )));
        await tester.pumpWidget(testWidget);
        final searchFinder = find.byType(SearchWidget);
        final listTileFinder = find.byType(ListTile);
        expect(searchFinder, findsOneWidget);
        expect(listTileFinder, findsWidgets);
      });
    });

    testWidgets('search for user', (tester) async {
      await tester.runAsync(() async {
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: PeopleView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.enterText(find.byType(SearchWidget).at(0), 'a');
        await tester.pumpAndSettle();
        final noUser = find.text('a');
        expect(noUser, findsWidgets);
      });
    });

    testWidgets('user not found', (tester) async {
      await tester.runAsync(() async {
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: PeopleView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.enterText(find.byType(SearchWidget).at(0), '24y');
        await tester.pumpAndSettle();
        final noUser = find.text('DOYLE TOBY');
        expect(noUser, findsNothing);
      });
    });

    testWidgets('navigate to details', (tester) async {
      await tester.runAsync(() async {
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: PeopleView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.enterText(find.byType(SearchWidget).at(0), 'doyl');
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ListTile).at(0));
        await tester.pumpAndSettle();
        expect(find.byType(PeopleView), findsNothing);
        expect(find.byType(PersonDetailView), findsOneWidget);
      });
    });
  });

  group('Competences View', () {
    testWidgets('creation', (tester) async {
      await tester.runAsync(() async {
        await CompetenceService.readData();
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: CompetencesView(),
            )));
        await tester.pumpWidget(testWidget);
        final imageFinder = find.byType(Image);
        final textFinder = find.byType(ExpandableText);
        expect(imageFinder, findsWidgets);
        expect(textFinder, findsWidgets);
      });
    });

    testWidgets('tap on details', (tester) async {
      await tester.runAsync(() async {
        await PeopleService.readData();
        await CompetenceService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: CompetencesView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(MaterialButton).at(0));
        await tester.pumpAndSettle();
        expect(find.byType(CompetencesView), findsNothing);
        expect(find.byType(CompetenceDetailView), findsOneWidget);
      });
    });
  });

  group('Technologies View', () {
    testWidgets('creation', (tester) async {
      await tester.runAsync(() async {
        await TechnologyService.readData();
        await PeopleService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: TechnologyView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        final textFinder = find.byType(Text);
        final gestureFinder = find.byType(GestureDetector);
        expect(gestureFinder, findsWidgets);
        expect(textFinder, findsWidgets);
      });
    });
  });

  group('KPIs View', () {
    testWidgets('creation', (tester) async {
      await tester.runAsync(() async {
        await TechnologyService.readData();
        await PeopleService.readData();
        await CompetenceService.readData();
        Widget testWidget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Material(
              child: KPIsView(),
            )));
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        final radarFinder = find.byType(RadarChart);
        expect(radarFinder, findsOneWidget);
      });
    });
  });
}
