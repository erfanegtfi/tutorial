import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tutorial/complete_profile.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/netowrk/dio_configuration.dart';
import 'package:tutorial/shared/styles/constants.dart';
import 'package:tutorial/verification_page.dart';

import 'login_page.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<User>(User());

  getIt.registerSingleton<Dio>(DioConfig.getDio());
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Provider<Cart>(
//       create: (_) => Cart(),
//       dispose: (_, cart) => cart.dispose(),
//       child: MaterialApp(
//         home: Home(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    VerificationPage.tag: (context) => VerificationPage(),
    // CompleteProfilePage.tag: (context) => CompleteProfilePage(),
    // RegisterPage.tag: (context) => RegisterPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(), //Login page Load on app launch
      routes: routes,
    );
  }
}
