import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tutorial/model/language.dart';
import 'package:tutorial/model/response/login_response.dart';
import 'package:tutorial/model/response/profile_response.dart';
import 'package:tutorial/model/response/verify_response.dart';
import 'package:tutorial/netowrk/rest_client.dart';
import 'package:tutorial/repository/authentication_repository.dart';
import 'package:tutorial/shared/utils/utils_dialog.dart';
part 'user.g.dart';

class User = UserBase with _$User;
enum LoadingState { none, loading, loaded, error }

abstract class UserBase with Store {
  BuildContext _context;
  String createdAt;
  String email;
  String fullName;
  int id;
  @observable
  Language language;
  int languageId;
  int status;
  String updatedAt;
  @observable
  LoadingState state = LoadingState.none;
  UserBase(
      {this.id,
      this.languageId,
      this.language,
      this.fullName,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt});

// String get getCode => code;

//   set setCode(String code) {
//     code = code;
//   }

  set setBuildContext(BuildContext _context) {
    this._context = _context;
  }

  String get getEmail => email;

  set setEmail(String email) {
    this.email = email;
  }

  Language get getLanguage => language;

  set setLanguageName(Language language) {
    this.language = language;
  }

  String get getName => fullName;

  set setName(String name) {
    this.fullName = name;
  }

  @action
  Future<VerfyResponse> verifyUser(String code) async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    Map<String, String> body = {'email': email, 'login_code': code, 'user_id': id.toString()};
    // state = LoadingState.loading;

    return client.verfyUser(body);
    // client.verfyUser(body).then((it) {
    //   state = LoadingState.loaded;
    // }).catchError((onError) {
    //   state = LoadingState.error;
    // });

    // AuthenticationRepository authRepository = new AuthenticationRepository();
    // state = LoadingState.loading;
    // authRepository.verifyUser(email, code, id.toString()).then((value) {
    //   state = LoadingState.loaded;
    // }).catchError((onError) {
    //    state = LoadingState.error;
    //   // if (onError is DioError)

    // });
  }

  @action
  Future<LoginResponse> login(String email) async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    Map<String, String> body = {'email': email};
    // state = LoadingState.loading;

    return client.login(body);
    // client.login(body).then((it) {
    //   this.id = it.user.id;
    //   this.email = it.user.email;
    //   state = LoadingState.loaded;
    // }).catchError((onError) {
    //   state = LoadingState.error;
    // });
  }

  @action
  Future<ProfileResponse> updateUserProfile(String fullName, String languageId, String id) async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    Map<String, String> body = {'fullName': fullName, 'languageId': languageId, 'user_id': id};
    // state = LoadingState.loading;
    return client.enterLanguage(body);
    // client.login(body).then((it) {
    //   state = LoadingState.loaded;
    // }).catchError((onError) {
    //   state = LoadingState.error;
    // });
  }

  UserBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
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
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['language_id'] = this.languageId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
