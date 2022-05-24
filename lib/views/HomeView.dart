import 'package:app/services/LoginService.dart';
import 'package:app/services/NavigatorService.dart';
import 'package:app/views/KPIsView.dart';
import 'package:app/views/LoginView.dart';
import 'package:app/views/PeopleView.dart';
import 'package:app/views/TechnologiesView.dart';
import 'package:app/views/commonWidgets/PageContainer.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

import 'CompetencesView.dart';

///Home page of whole app.
///Defines 4 different pages:
/// - People: List of people in CoE
/// - Competences: Competences of CoE
/// - Technologies: Technologies of each competence in Coe
/// - KPIs: Graphical information about different knowledge for each competence in CoE.
///
/// This class supports transitions beetween pages and a log out button to close session.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      setState(() {});
    });
  }

  int _selectedIndex = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  static List<Widget> _widgetOptions = <Widget>[
    PageContainer(child: PeopleView()),
    PageContainer(child: CompetencesView()),
    PageContainer(child: TechnologyView()),
    PageContainer(child: KPIsView())
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          curve: Curves.decelerate, duration: Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
            tag: 'CoeLogo',
            child: Image(image: AssetImage('images/icons/icon.png'))),
        title: Text(widget.title, style: AppText.appBar),
        elevation: 15,
        backgroundColor: AppColors.color4,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                    await LoginService.deleteUser();
                    NavigateService.navigateWithFadeWithReplacement(context,
                        objective: LoginView());
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: PageView(
        children: _widgetOptions,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 5)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: BottomNavigationBar(
            iconSize: 30,
            unselectedItemColor: AppColors.color9,
            selectedItemColor: AppColors.color12,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                //icon: Icon(Icons.person_pin_circle_sharp),
                icon: ImageIcon(AssetImage('images/pages/people.png')),
                label: 'People',
              ),
              BottomNavigationBarItem(
                //icon: Icon(Icons.school),
                icon: ImageIcon(AssetImage('images/pages/competences.png')),

                label: 'Competences',
              ),
              BottomNavigationBarItem(
                //icon: Icon(Icons.devices),
                icon: ImageIcon(AssetImage('images/pages/technologies.png')),
                label: 'Technologies',
              ),
              BottomNavigationBarItem(
                //icon: Icon(Icons.track_changes),
                icon: ImageIcon(AssetImage('images/pages/kpis.png')),
                label: 'KPIs',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
