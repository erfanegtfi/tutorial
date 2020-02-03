import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/netowrk/dio_configuration.dart';

class UtilsPrefrence {
  static void storeUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user-token", token).then((bool success) {
      DioConfig.setUserTokenHeader(token);
    });
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user-token");
  }
}
