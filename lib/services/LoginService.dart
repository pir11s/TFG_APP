import 'package:shared_preferences/shared_preferences.dart';

import '../models/LoginModel.dart';

class LoginService {
  static LoginModel user = LoginModel(user: "", password: "");
  static bool rememberMe = false;
  static bool hidePassword = true;
  static RegExp userPattern = RegExp('n{1}[0-9]{5}');
  LoginService._();

  static bool authenticateUser() {
    return true;
  }

  static void changeRemember() {
    rememberMe = !rememberMe;
  }

  static void changeHide() {
    hidePassword = !hidePassword;
  }

  static void saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', user.user);
    prefs.setString('password', user.password);
  }

  static LoginModel getUserInfo() {
    return user;
  }

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.user = (prefs.getString('userName') ?? 'a');
  }

  static getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.password = (prefs.getString('password') ?? 'b');
  }

  static void setUser(String newUser) {
    user.user = newUser;
  }

  static void setPassword(String newPassword) {
    user.password = newPassword;
  }

  static Future deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', '');
    prefs.setString('password', '');
    setUser('');
    setPassword('');
  }

  static bool checkUserPatternOK(String user) {
    return userPattern.firstMatch(user) != null ? true : false;
  }

  static bool checkPasswdNotEmpty(String passwd) {
    return passwd != "" ? true : false;
  }

  static bool getRememberMe() {
    return rememberMe;
  }

  static bool getHidePassword() {
    return hidePassword;
  }
}
