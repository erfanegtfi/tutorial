
import 'package:tutorial/model/meta.dart';

class BaseResponse {
   Meta meta;

  BaseResponse({this.meta});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}