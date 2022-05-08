import 'package:app/views/CompetencesView.dart';
import 'package:app/views/PeopleView.dart';
import 'package:app/views/TechnologiesView.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

//Navigator of application. Defines some animated navigations.
class NavigateService {
  NavigateService._();

  static void navigateWithFadeWithReplacement(BuildContext context,
      {required Widget objective}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return objective;
          }),
    );
  }

  static void navigateDetailEmployee(id, context) {
      Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title:
                  Text('Person info & knowledge', style: AppText.appBar),
              elevation: 15,
              backgroundColor: AppColors.color4,
            ),
            body: PersonDetailView(id: id),
          );
        },
      ),
    );
  }

  static void navigateDetailTechnology(String technologyName, context) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: Text('Technology knowledge', style: AppText.appBar),
              elevation: 15,
              backgroundColor: AppColors.color4,
            ),
            body: TechnologyDetailView(
              technologyName: technologyName,
            ),
          );
        },
      ),
    );
  }

  static navigateDetailCompetence(competenceName,context) {
      Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimation) {
                          return CompetenceDetailView(
                            competenceName: competenceName,
                          );
                        }),
                      );
  }
}