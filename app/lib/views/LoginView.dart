import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';

class LoginView extends StatefulWidget {
  @override
   @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

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
                          key: Key(''),
                          initialValue: '',
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
                            //TODO
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
                          key: Key(''),
                          initialValue: '',
                          decoration: InputDecoration(
                            hintText: "Password",
                                  contentPadding:
                                      EdgeInsets.only(top: 20, left: 2),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 2),
                                    child: Icon(Icons.visibility),
                                  )
                          ),
                          validator: (value) {
                            //TODO
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
                            value: true,
                           onChanged: (_) {
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
                            onPressed: () {} 
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