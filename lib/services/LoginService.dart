import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:universal_platform/universal_platform.dart';
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

  static void saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', user.user);
    prefs.setString('password', user.password);
  }

  static LoginModel getUserInfo() {
    return user;
  }

  static recoverUsernameData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.user = (prefs.getString('userName') ?? '');
  }

  static recoverPasswordData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.password = (prefs.getString('password') ?? '');
  }

  static void setUser(String newUser) {
    user.user = newUser;
  }

  static void setPassword(String newPassword) {
    user.password = newPassword;
  }

  static Future deleteUserData() async {
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

  static List<Widget> getPlatform() {
      if (UniversalPlatform.isAndroid) {
        return <Widget>[
          Icon(
            Icons.fingerprint,
            size: 36,
          ),
          Text(
            'Access by placing your fingerprint on the sensor',
            style: TextStyle(color: AppColors.color1),
          )
        ];
      } else if (UniversalPlatform.isIOS) {
        return <Widget>[
          Image(
            image: ResizeImage(AssetImage('images/icons/ios_log_icon.png'),
                height: 36, width: 36),
          ),
          Text(
            'Access with face Id',
            style: TextStyle(color: AppColors.color1),
          )
        ];
      } else {
        return <Widget>[SizedBox(height: 0)];
      }
    }

}
