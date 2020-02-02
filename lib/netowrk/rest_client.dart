import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tutorial/model/response/course_list_response.dart';
import 'package:tutorial/model/response/login_response.dart';
import 'package:tutorial/model/response/profile_response.dart';
import 'package:tutorial/model/response/verify_response.dart';
part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("course/index")
  Future<CourseListResponse> getTasks();

  @POST("user/login/enter-login-code")
  Future<VerfyResponse> verfyUser(@Body() Map<String, dynamic> map);

  @POST("user/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> map);

  @POST("user/login/enter-language")
  Future<ProfileResponse> enterLanguage(@Body() Map<String, dynamic> map);
}