import 'package:tutorial/model/response/base_response.dart';
import 'package:tutorial/model/user.dart';

class LoginResponse extends BaseResponse{
  LoginResponse({this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  User user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}