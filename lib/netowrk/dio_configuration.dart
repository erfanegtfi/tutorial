import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tutorial/shared/styles/constants.dart';

class DioConfig {
  static Dio getDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 100000,
      headers: getDioHeaders(),
      // validateStatus: (status) {
      //   return status < 500;
      // },
    ));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 110));

    return dio;
  }

  static Map<String, dynamic> getDioHeaders() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  static setUserTokenHeader(String token) {
    Dio dio = GetIt.instance<Dio>();
    dio.options.headers["Authorization"] = "Bearer " + token;
  }
}
