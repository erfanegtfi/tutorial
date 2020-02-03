import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tutorial/model/response/course_list_response.dart';
import 'package:tutorial/netowrk/loading_state.dart';
import 'package:tutorial/netowrk/rest_client.dart';
import 'package:tutorial/shared/styles/constants.dart';
part 'sub_course.g.dart';

class SubCourse = SubCourseBase with _$SubCourse;
enum LoadingState { none, loading, loaded, error }

abstract class SubCourseBase with Store {
  int id;
  int userCreatorId;
  int courseId;
  String title;
  String type;
  String indexImg;
  String createdAt;
  String updatedAt;
  int courseUserCount;
  bool listLoading = false;
  // @observable
  // var state = InitialState();
  @observable
  LoadingState loadingState = LoadingState.none;
  @observable
  ObservableList<SubCourse> _courseList = ObservableList<SubCourse>();
  ObservableList<SubCourse> get courseList => _courseList;
  @observable
  DioError courseListError;

  SubCourseBase(
      {this.id, this.userCreatorId, this.title, this.indexImg, this.createdAt, this.updatedAt, this.courseUserCount});

  @action
  Future<void> getCourseList() async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    loadingState = LoadingState.loading;

    // return client.getCourseList();
    client.getSubCourseList(id).then((it) {
      // if (_courseList.length > 0 && _courseList.elementAt(_courseList.length - 1).listLoading)
      //   _courseList.removeAt(_courseList.length - 1);

      loadingState = LoadingState.loaded;
      _courseList.addAll(it.subCourseList);

      // if (_courseList.length >= Constants.PAGINATION) {
      //   SubCourse c = SubCourse();
      //   c.listLoading = true;
      //   _courseList.add(c);
      // }
    }).catchError((onError) {
      loadingState = LoadingState.error;
    });
  }

  SubCourseBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreatorId = json['user_creator_id'];
    courseId = json['course_id'];
    title = json['title'];
    type = json['type'];
    indexImg = json['index_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseUserCount = json['course_user_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_creator_id'] = this.userCreatorId;
    data['course_id'] = this.courseId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['index_img'] = this.indexImg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_user_count'] = this.courseUserCount;
    return data;
  }
}
