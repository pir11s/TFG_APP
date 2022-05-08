import 'package:app/views/LoginView.dart';
import 'package:app/views/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santander Global Tech',
      theme: AppTheme.themeData,
      home: LoginView(),
    );
  }
}
