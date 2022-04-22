
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LoginModel.dart';

class LoginService {

  static LoginModel user = LoginModel("","");
  static bool rememberMe = false;
  static bool hidePassword = true;
  static RegExp userPattern = RegExp('n{1}[0-9]{5}');

  static bool authenticate_user()  {
    return true;
  }

  static void change_remember(){
    rememberMe = !rememberMe;
  }

  static void change_hide(){
    hidePassword = !hidePassword;
  }

  

  static  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.user = (prefs.getString('userName') ?? '');
  }

  static getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.password = (prefs.getString('password') ?? '');
  }

  static void setUser(String newUser) {
      user.user = newUser;
  }
  
  static void setPassword(String newPassword) {
    user.password = newPassword;
  }

  static Future saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('user', user.user);
    prefs.setString('password', user.password);
  }

  static Future deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    prefs.setString('password', '');
  }

  static bool checkUserPatternOK(String user) {
    return userPattern.firstMatch(user) != null ?  true : false;
  }

  static bool checkPasswdNotEmpty(String passwd) {
    return passwd != "" ? true: false;
  }

}