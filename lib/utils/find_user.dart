import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindUser {
  static Future<bool> findUser(List userData,
      {required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString("userEmail");
      final userPassword = prefs.getString("userPassword");
      if (userEmail == emailController.text &&
          userPassword == passwordController.text) {
        return true;
      }
      return false;
    } catch (e) {
      throw e.toString();
    }
  }
}
