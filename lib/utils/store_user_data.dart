import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserData(
    {required String userName,
    required String userEmail,
    required String userPassword}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userEmail", userEmail);
    prefs.setString("userPassword", userPassword);
  } catch (e) {
    throw e.toString();
  }
}
