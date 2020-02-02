import 'dart:async';
import 'dart:convert' as JSON;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/model/response/login_response.dart';
import 'package:tutorial/model/response/profile_response.dart';
import 'package:tutorial/model/response/verify_response.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/netowrk/dio_configuration.dart';
import 'package:tutorial/shared/styles/constants.dart';
import 'package:tutorial/shared/utils/utils_dialog.dart';

// https://javiercbk.github.io/json_to_dart/
class AuthenticationRepository {
  Future<LoginResponse> loginUser(String email) async {
    var client = GetIt.instance<Dio>();

    Map<String, String> body = {'email': email};

    Response response = await client.post(
      "user/login",
      data: body,
    );

    final statusCode = response.statusCode;
    if (statusCode != 200 || response.data == null) {
      throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    }
    return LoginResponse.fromJson(response.data);
  }

  Future<VerfyResponse> verifyUser(String email, String code, String id) async {
    var client = GetIt.instance<Dio>();

    Map<String, String> body = {'email': email, 'login_code': code, 'user_id': id};
    Response response;
    try {
      response = await client.post(
        "user/login/enter-login-code",
        data: body,
      );
    } on DioError catch (e) {
      throw e;
      // if (e.response != null) {
      //   response = e.response;
      // } else {
      //   print(e.request);
      //   print(e.message);
      // }
    }
    // final statusCode = response.statusCode;
    // if (statusCode != 200 || response.data == null) {
    //   throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    // }
    VerfyResponse verifyRes = VerfyResponse.fromJson(response.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user-token", verifyRes.data.token).then((bool success) {
      DioConfig.setUserTokenHeader(verifyRes.data.token);
    });
    return verifyRes;
  }

  Future<ProfileResponse> updateUserProfile(String fullName, String languageId, String id) async {
    var client = GetIt.instance<Dio>();

    Map<String, String> body = {'fullName': fullName, 'languageId': languageId, 'user_id': id};

    Response response = await client.post(
      "user/login/enter-language",
      data: body,
    );

    final statusCode = response.statusCode;
    if (statusCode != 200 || response.data == null) {
      throw new Exception("An error ocurred AuthenticationRepository : [Status Code : $statusCode]");
    }
    return ProfileResponse.fromJson(response.data);
  }
}
