import 'package:tutorial/model/language.dart';
import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/base_response.dart';

class ProfileResponse extends BaseResponse {
  Data data;

  ProfileResponse({this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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
  int id;
  String languageId;
  String fullName;
  String email;
  int status;
  String createdAt;
  String updatedAt;
  Language language;

  Data(
      {this.id,
      this.languageId,
      this.fullName,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.language});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    fullName = json['full_name'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
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
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}
