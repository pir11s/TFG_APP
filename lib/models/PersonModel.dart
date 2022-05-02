import 'package:app/models/TechnologyModel.dart';

///Login information
///
/// - String user: user identifier. ex: n123456
/// - String password: user password
class PersonModel {

  String user;
  String displayName;
  String jobTitle;
  String mail;
  String mobilePhone;
  String officeLocation;
  String prefferedLanguage;
  String surname;
  String userPrincipalName;
  String id;
  String competence;
  String function;
  List<TechnologyModel> technologies;
  String image;
  String businessPhone;
  PersonModel({required this.user, required this.displayName,required this.jobTitle,required this.mail, required this.mobilePhone,
              required this.officeLocation,required this.prefferedLanguage,required this.surname,required this.userPrincipalName,
              required this.id,required this.competence,required this.function,required this.technologies,required this.image,required this.businessPhone});

}

/*
 "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
               "businessPhones": [
                    "+34 559230369"
               ],
               "displayName": "PRUITT SAIMA",
               "givenName": "SAIMA",
               "jobTitle": "Specialist I",
               "mail": "saima@gmail.com",
               "mobilePhone": "+34 559230369",
               "officeLocation": "Buxton",
               "preferredLanguage": null,
               "surname": "PRUITT",
               "userPrincipalName": "n145220@santander.com",
               "id": "aaaaa-aaaaa-aaaaa-aaaaa"
*/