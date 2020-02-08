import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/netowrk/dio_configuration.dart';

class UtilsPrefrence {
  static Future<void> storeUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user-token", token).then((bool success) {
      DioConfig.setUserTokenHeader(token);
    });
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user-token");
  }
}
