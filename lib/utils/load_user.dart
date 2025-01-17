import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LoadUser {
  static Future<List<Map<String, dynamic>>> loadUser() async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/signup_data.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return [];
    }
  }
}
