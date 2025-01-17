import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreData {
  static Future<void> storeData(
      {required String userName,
      required String userEmail,
      required String userPassword}) async {
    try {
      List<Map<String, dynamic>> userData = [
        {
          "userName": userName,
          "userEmail": userEmail,
          "userPassword": userPassword,
        }
      ];
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/signup_data.json');
      if (!await file.exists()) {
        await file.create();
      }
      final jsonString = await file.readAsString();
      final dynamic existingData;
      if (jsonString.isNotEmpty) {
        existingData = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
      } else {
        existingData = [];
      }
      existingData.add(userData[0]);
      final updatedJsonString = jsonEncode(existingData);
      await file.writeAsString(updatedJsonString);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userEmail", userEmail);
      prefs.setString("userPassword", userPassword);
    } catch (e) {
      throw e.toString();
    }
  }
}
