import 'package:app/services/CompetenceService.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/services/PeopleService.dart';
import 'package:app/services/TechnologyService.dart';
import 'package:app/views/commonWidgets/PageContainer.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

///Default page if user is already logged in. Displays for 3 seconds a screen with a loading
///animation. If user is not logged in this page will display after log.
class LoadingScreenView extends StatefulWidget {
  LoadingScreenView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoadingScreenViewState createState() => _LoadingScreenViewState();
}

class _LoadingScreenViewState extends State<LoadingScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await TechnologyService.readData();
      await CompetenceService.readData();
      await PeopleService.readData();
      setState(() {});
    });

    NavigateService.navigateHome(context, widget.title);
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
                            image: ResizeImage(
                                AssetImage("images/icons/icon.png"),
                                width: 150,
                                height: 150),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                            fontFamily: 'packages/tfg_theme/SantanderHeadline',
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
