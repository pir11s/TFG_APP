
import 'package:app/services/PeopleService.dart';
import 'package:app/views/PeopleView.dart';
import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

//Default displayable avatar of an employee. Loads assigned image to user or image default. Displays the image as a circle and
///writes user name and lastname under it.
class MiniAvatar extends StatelessWidget {
  MiniAvatar({required this.id});

  final String id;

  ///PersonDetail navigator.
  ///
  ///Parameters:
  ///
  /// - Int id: id of employee
  /// - Context context: context of widget that navigates
  void _detalleEmpleado(id, context) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title:
                  Text('Person info & knowledge', style: AppText.appBar),
              elevation: 15,
              backgroundColor: AppColors.color4,
            ),
            body: PersonDetailView(id: id),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {

    return Container(
      width: 90,
      child: Material(
          color: Color(0x00000000),
          child: GestureDetector(
            onTap: () {
              _detalleEmpleado(id, context);
            },
            child: Hero(
              tag: 'avatar-$id',
              child: Column(
                children: [
                  Container(
                    decoration: PeopleService.hasImageById(id)
                        ? BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: AppColors.color6,
                                  spreadRadius: 1)
                            ],
                          )
                        : null,
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundColor:
                         PeopleService.hasImageById(id)
                              ? AppColors.color6
                              : Color(0x00000000),
                      backgroundImage: PeopleService.getAvatar(id),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      PeopleService.getEmployeeById(id).displayName,
                      style: AppText.bodyTextOutstandingModule
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}