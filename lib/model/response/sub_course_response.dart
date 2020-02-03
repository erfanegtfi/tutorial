import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/base_response.dart';
import 'package:tutorial/model/sub_course.dart';

class SubCourseResponse extends BaseResponse{
  List<SubCourse> subCourseList;

  SubCourseResponse({this.subCourseList});

  SubCourseResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      subCourseList = new List<SubCourse>();
      json['data'].forEach((v) {
        subCourseList.add(new SubCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.subCourseList != null) {
      data['data'] = this.subCourseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}