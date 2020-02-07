import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tutorial/model/file.dart';
import 'package:tutorial/model/meta.dart';
import 'package:tutorial/model/response/course_list_response.dart';
import 'package:tutorial/netowrk/loading_state.dart';
import 'package:tutorial/netowrk/rest_client.dart';
import 'package:tutorial/shared/styles/constants.dart';
part 'course.g.dart';

class Course = CourseBase with _$Course;

abstract class CourseBase with Store {
  int id;
  int userCreatorId;
  int languageId;
  String title;
  String indexImg;
  String description;
  String createdAt;
  String updatedAt;
  String type;
  File file;
  int courseUserCount;
  bool listLoading = false;
  //  bool detailLoading = false;
  int page = 1;
  // @observable
  // var state = InitialState();
  @observable
  LoadingState loadingState = LoadingState.none;
  @observable
  Course course;
  @observable
  ObservableList<Course> _courseList = ObservableList<Course>();
  ObservableList<Course> get courseList => _courseList;
  @observable
  Meta courseListError;

  CourseBase(
      {this.id,
      this.userCreatorId,
      this.languageId,
      this.title,
      this.indexImg,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.courseUserCount});

  @action
  Future<void> getCourseList() async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    if(page==1)
    loadingState = LoadingState.loading;

    // return client.getCourseList();
    client.getCourseList(page).then((it) {
      if (_courseList.length > 0 && _courseList.elementAt(_courseList.length - 1).listLoading)
        _courseList.removeAt(_courseList.length - 1);

      loadingState = LoadingState.loaded;
      _courseList.addAll(it.data.course);

      if (it.data.currentPage < it.data.lastPage) {
        Course c = Course();
        c.listLoading = true;
        _courseList.add(c);
      }
      page++;
    }).catchError((onError) {
      loadingState = LoadingState.error;
    });
  }

  @action
  Future<void> getCourse(int courseid) async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    loadingState = LoadingState.loading;

    // return client.getCourseList();
    client.getCourse(courseid).then((it) {
      course = it.course;
       loadingState = LoadingState.loaded;
    }).catchError((onError) {
      loadingState = LoadingState.error;
      Map<String, dynamic> responseBody = (onError as DioError).response.data;
      courseListError = Meta.fromJson(responseBody["meta"]);
    });
  }

  CourseBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreatorId = json['user_creator_id'];
    languageId = json['language_id'];
    title = json['title'];
    indexImg = json['index_img'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseUserCount = json['course_user_count'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_creator_id'] = this.userCreatorId;
    data['language_id'] = this.languageId;
    data['title'] = this.title;
    data['index_img'] = this.indexImg;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_user_count'] = this.courseUserCount;
     if (this.file != null) {
      data['file'] = this.file.toJson();
    }
    return data;
  }
}
