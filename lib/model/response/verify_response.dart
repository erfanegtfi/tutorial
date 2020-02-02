import 'package:tutorial/model/language.dart';
import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/base_response.dart';
import 'package:tutorial/model/user.dart';

class VerfyResponse  extends BaseResponse{
  Data data;

  VerfyResponse({this.data});

  VerfyResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}


class Data {
  User user;
  String token;
  List<Language> language;

  Data({this.user, this.token, this.language});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    if (json['language'] != null) {
      language = new List<Language>();
      json['language'].forEach((v) {
        language.add(new Language.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    if (this.language != null) {
      data['language'] = this.language.map((v) => v.toJson()).toList();
    }
    return data;
  }
}