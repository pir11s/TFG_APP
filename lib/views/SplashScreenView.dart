
import 'package:app/services/CompetenceService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:app/views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';


///Default page if user is already logged in. Displays for 3 seconds a screen with a loading
///animation. If user is not logged in this page will display after log.
class MySplash extends StatefulWidget {
  MySplash({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

 

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await TechnologyService.read_data();
      await CompetenceService.read_data();
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1500),
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
              return MyHomePage(
                title: widget.title,
              );
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Center(
                        child: Hero(
                          tag: 'CoeLogo',
                          child: Image(
                            image: ResizeImage(AssetImage("images/icons/icon.png"),
                                width: 150, height: 150),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                      ,
                      Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                            fontFamily: 'packages/san_theme/SantanderHeadline',
                            color: AppColors.color9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: LoadingBouncingLine.circle(
                    borderColor: AppColors.color12,
                    backgroundColor: Colors.white10,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: footText(
                      '"We believe how we do things is as important as what we do"'),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text footText(text) {
    return Text(
      text,
      style: AppText.bodyOutstandingText,
      textAlign: TextAlign.center,
    );
  }
}


///Default Container of pages. Defines a standard background color for it's child.
///
///Atributes:
/// - Widget child: child of PageContainer.
class PageContainer extends StatelessWidget {
  PageContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: child),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0x6688c4d5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
        ),
      ),
    );
  }
}