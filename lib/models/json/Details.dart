class Details {
  List<EmployeeDetail>? employeesDetails;

  Details({this.employeesDetails});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employeesDetails = <EmployeeDetail>[];
      json['employees'].forEach((v) {
        employeesDetails!.add(new EmployeeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeesDetails != null) {
      data['employees'] = this.employeesDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeDetail {
  String? odataContext;
  List<String>? businessPhones;
  String? displayName;
  String? givenName;
  String? jobTitle;
  String? mail;
  String? mobilePhone;
  String? officeLocation;
  String? preferredLanguage;
  String? surname;
  String? userPrincipalName;
  String? id;

  EmployeeDetail(
      {this.odataContext,
      this.businessPhones,
      this.displayName,
      this.givenName,
      this.jobTitle,
      this.mail,
      this.mobilePhone,
      this.officeLocation,
      this.preferredLanguage,
      this.surname,
      this.userPrincipalName,
      this.id});

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    businessPhones = json['businessPhones'].cast<String>();
    displayName = json['displayName'];
    givenName = json['givenName'];
    jobTitle = json['jobTitle'];
    mail = json['mail'];
    mobilePhone = json['mobilePhone'];
    officeLocation = json['officeLocation'];
    preferredLanguage = json['preferredLanguage'];
    surname = json['surname'];
    userPrincipalName = json['userPrincipalName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    data['businessPhones'] = this.businessPhones;
    data['displayName'] = this.displayName;
    data['givenName'] = this.givenName;
    data['jobTitle'] = this.jobTitle;
    data['mail'] = this.mail;
    data['mobilePhone'] = this.mobilePhone;
    data['officeLocation'] = this.officeLocation;
    data['preferredLanguage'] = this.preferredLanguage;
    data['surname'] = this.surname;
    data['userPrincipalName'] = this.userPrincipalName;
    data['id'] = this.id;
    return data;
  }
}
