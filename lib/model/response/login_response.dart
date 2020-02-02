import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/base_response.dart';
import 'package:tutorial/model/user.dart';

class LoginResponse extends BaseResponse {
  User  user;

  LoginResponse({this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}
