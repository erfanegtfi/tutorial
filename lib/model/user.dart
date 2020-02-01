import 'package:mobx/mobx.dart';
part 'user.g.dart';

class User = UserBase with _$User;

abstract class UserBase with Store {

  String createdAt;
  String email;
  String fullName;
  int id;
  int languageId;
  @observable
  String languageName="";

  int status;
  String updatedAt;

  UserBase({this.id, this.languageId, this.fullName, this.email, this.status, this.createdAt, this.updatedAt});

// String get getCode => code;

//   set setCode(String code) {
//     code = code;
//   }

  String get getEmail => email;

  set setEmail(String email) {
    this.email = email;
  }

  String get getLanguageName => languageName;

  set setLanguageName(String languageName) {
    this.languageName = languageName;
  }

  String get getName => fullName;

  set setName(String name) {
    this.fullName = name;
  }

UserBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    fullName = json['full_name'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
