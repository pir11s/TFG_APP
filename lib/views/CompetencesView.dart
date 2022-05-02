
import 'package:app/services/CompetenceService.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';


///List of CoE competences. Each competences has a title and related text, plus an image to describe
///the competence. If any competence is clicked a CompetenceDetail widget is displayed.
class CompetencesView extends StatefulWidget {
  @override
  _CompetencesState createState() => _CompetencesState();
}

class _CompetencesState extends State<CompetencesView> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        child: ListView.separated(
          separatorBuilder: (content, index) {
            return Divider(
              height: 25,
            );
          },
          itemCount: CompetenceService.competences.length,
          itemBuilder: (context, index) {
            String key = CompetenceService.competences.keys.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: MaterialButton(
                    onPressed: () {
                      
                    },
                    child: Row(
                      children: [
                        competenceImage(key),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        competenceText(key),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded competenceImage(String key) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: (key == "")
              ? const EdgeInsets.only(top: 15.0)
              : const EdgeInsets.only(),
          child: Hero(
            tag: 'CompetenceImageDetail' + CompetenceService.competences[key]!.competenceName,
            child: Image(
              image: ResizeImage(AssetImage(CompetenceService.competences[key]!.image),
                  width: 200, height: 150),
            ),
          ),
        ));
  }

   Expanded competenceText(String key) {
    return Expanded(
      flex: 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              CompetenceService.competences[key]!.competenceName,
              style: TextStyle(fontSize: 24, color: AppColors.color12),
            ),
          ),
          ExpandableText(
             CompetenceService.competences[key]!.description,
            textAlign: TextAlign.justify,
            expandText: 'show more',
            collapseText: 'show less',
            animation: true,
            animationDuration: Duration(milliseconds: 700),
            maxLines: 4,
            linkColor: AppColors.color12,
          )
        ],
      ),
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