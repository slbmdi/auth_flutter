import 'package:flutter/material.dart';

class ConstColor {
  static Color backgroundAppBar = const Colo.fromARGB(255, 113, 236, 129);
}

class ConstAPi {
  static String main = 'http://192.168.33.152:8000/api/v1/';
  static String login = '${main}login';
  static String checkCode = '${main}check-code';
  static String register = '${main}register';
  static String me = '${main}me';
  static String logout = '${main}logout';
}
