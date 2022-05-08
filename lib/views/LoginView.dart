import 'package:app/services/LoginService.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/views/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:tfg_theme/AppColors.dart';

class LoginView extends StatefulWidget {
  @override
   @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await LoginService.getPassword();
      await LoginService.getUser();
     
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('CoE Full Stack',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 48),)
                    
                  ],
                ),
                Text('Welcome',style: Theme.of(context).textTheme.headline4),
                Row(
                  children: [
                    Expanded(child: SizedBox(),flex: 1),
                    Expanded(
                      flex: 10,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          key: Key(LoginService.user.user),
                          initialValue: LoginService.user.user,
                          decoration: InputDecoration(
                            hintText: "User",
                                  contentPadding:
                                      EdgeInsets.only(top: 20, left: 2),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 2),
                                    child: Icon(Icons.account_circle),
                                  )
                          ),
                          validator: (value) {
                            if (LoginService.checkUserPatternOK(value!)) {
                                setState(() {
                                  LoginService.setUser(value);
                                });
                            } else {
                              return 'Please enter username (Ej: n12345)';
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox(),flex: 1),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox(),flex: 1),
                    Expanded(
                      flex: 10,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          key: Key(LoginService.user.password),
                          initialValue: LoginService.user.user,
                          obscureText: LoginService.hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                                  contentPadding:
                                      EdgeInsets.only(top: 20, left: 2),
                                  suffixIcon: IconButton(
                                   onPressed: () {
                                      setState(() {
                                        LoginService.change_hide();
                                      });
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Icon(LoginService.hidePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    )
                                  )
                          ),
                          validator: (value) {
                            if (LoginService.checkPasswdNotEmpty(value!)) {
                              setState(() {
                                LoginService.setPassword(value);
                              });
                            } else {
                              return 'Please enter your password';
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox(),flex: 1),
                  ],
                ),
                Column(
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Checkbox(
                            //todo
                            value: LoginService.rememberMe,
                           onChanged: (_) {
                             setState(() {
                               LoginService.change_remember();
                             });
                            }
                        ),
                        Text(
                            'Remember me',
                            style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: AppColors.color12,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.antiAlias,
                          child: MaterialButton(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)
                              ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  if ( LoginService.authenticate_user()) {
                                    if (LoginService.rememberMe == true) {
                                          
                                        } else {
                                          
                                        }
                                     NavigateService
                                            .navigateWithFadeWithReplacement(
                                                context,
                                                objective: LoadingScreenView(
                                                  title: "CoE Full Stack",
                                                ));
                                  } else {
                                    Fluttertoast.showToast(
                                            msg:
                                                "Can't login. Please check username/password.",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: Colors.red,
                                            textColor: AppColors.color5,
                                            timeInSecForIosWeb: 2,
                                            webPosition: "center",
                                            webBgColor: "#cccccc",
                                            fontSize: 16.0);
                                  }
                                  
                                });
                              }
                            } 
                          )
                        )
                      ])
                  ],
                )
              ],
            )
            )

        ],
      ),
    );
  }

} 