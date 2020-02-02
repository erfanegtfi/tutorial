import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/response/login_response.dart';
import 'package:tutorial/netowrk/rest_client.dart';

// https://javiercbk.github.io/json_to_dart/
class AuthenticationRepository {
  Future<LoginResponse> getCourseList() async {
    var dio = GetIt.instance<Dio>();
    final client = RestClient(dio);
    client.getTasks().then((it) {}).catchError((onError) {});

    // final statusCode = response.statusCode;
    // if (statusCode != 200 || response.data == null) {
    //   throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    // }
    // return LoginResponse.fromJson(response.data);
  }
}
