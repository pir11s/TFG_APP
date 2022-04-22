import 'package:flutter/material.dart';

//Navigator of application. Defines some animated navigations.
class SantanderNavigate {
  SantanderNavigate._();

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
}