import 'dart:async';
import 'dart:convert' as JSON;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial/model/response/login_response.dart';
import 'package:tutorial/model/response/verify_response.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/shared/styles/constants.dart';

// https://javiercbk.github.io/json_to_dart/
class AuthenticationRepository {
  Future<LoginResponse> loginUser(String email) async {
    var client = Dio(BaseOptions(baseUrl: Constants.baseUrl));

    Map<String, String> body = {'email': email};

    Response response = await client.post(
      "user/login",
      data: body,
    );

    print("AuthenticationRepository ${response}");
    final statusCode = response.statusCode;
    print("AuthenticationRepository {$statusCode}");
    if (statusCode != 200 || response.data == null) {
      throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    }
    return LoginResponse.fromJson(response.data);
  }

  Future<VerfyResponse> verifyUser(String email, String code, String id) async {
    var client = Dio(BaseOptions(baseUrl: Constants.baseUrl));

    Map<String, String> body = {'email': email, 'login_code': code, 'user_id': id};
    print("verifyUser ${body}");

    Response response = await client.post(
      "user/login/enter-login-code",
      data: body,
    );

    print("verifyUser ${response.data}");
    final statusCode = response.statusCode;
    print("verifyUser {$statusCode}");
    if (statusCode != 200 || response.data == null) {
      throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    }
    return VerfyResponse.fromJson(response.data);
  }
}
