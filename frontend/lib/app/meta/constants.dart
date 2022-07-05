import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppConstants {
  AppConstants._();

  //static String baseUrl = "http://127.0.0.1:8000";// this is for the development
  static String baseUrl = "https://prymo-backend.herokuapp.com"; // this is also for production

  static String authToken = "bf5d6b7a34b7907d75f08a1dc2c165769219c70b"; // this is for production
  //static String authToken = "364eb4ec7d4d948cbbcc7f2452246bced8895f1c"; // this is for the development
  static Color mainColor = Colors.blue;
}

class HiveRepository {
  const HiveRepository._();
  static void saveToken(String data) {
    var box = Hive.box('authBox');
    box.put('token', data);
  }

  static void saveUserName(String data) {
    var box = Hive.box('usernamebox');
    box.put('username', data);
  }

  static Future<String> getUserName() async {
    var box = Hive.box('usernamebox');
    return await box.get("username");
  }

  static Future<String> getToken() async {
    var box = Hive.box('authBox');

    return await box.get("token");
  }
}
