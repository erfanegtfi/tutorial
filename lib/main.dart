import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/course.dart';
import 'package:tutorial/model/sub_course.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/netowrk/dio_configuration.dart';
import 'package:tutorial/shared/utils/utils_prefrence.dart';
import 'package:tutorial/ui/authentication/login_page.dart';
import 'package:tutorial/ui/authentication/verification_page.dart';
import 'package:tutorial/ui/course/course_list_page.dart';
import 'package:tutorial/ui/details/audio_player.dart';
import 'package:tutorial/ui/details/detail_page.dart';
import 'package:tutorial/ui/details/video_player.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<User>(User());
  getIt.registerSingleton<Course>(Course());
 getIt.registerSingleton<SubCourse>(SubCourse());

  getIt.registerSingleton<Dio>(DioConfig.getDio());

  WidgetsFlutterBinding.ensureInitialized();
  UtilsPrefrence.getUserToken().then((token) {
    DioConfig.setUserTokenHeader(token);

    runApp(MyApp(token!=null));
  });
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    VerificationPage.tag: (context) => VerificationPage(),
    // CompleteProfilePage.tag: (context) => CompleteProfilePage(),
    // RegisterPage.tag: (context) => RegisterPage(),
  };


  bool userLoggedIn;
  MyApp(this.userLoggedIn);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Nunito',
      ),
      home: userLoggedIn ? CourseListPage() : LoginPage(), //Login page Load on app launch
      // home:  DetailsPage(1),
      // home : AudioApp(),
      routes: routes,
    );
  }
}
