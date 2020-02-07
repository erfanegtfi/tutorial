import 'package:tutorial/model/course.dart';
import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/base_response.dart';

class CourseDetailResponse extends BaseResponse {
  Course course;

  CourseDetailResponse({this.course});

  CourseDetailResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    course = json['data'] != null ? new Course.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.course != null) {
      data['data'] = this.course.toJson();
    }
    return data;
  }
}
