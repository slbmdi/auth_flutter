import 'dart:developer';

import 'package:auth_flutter/helper/constance.dart';
import 'package:auth_flutter/model/user_model.dart';
import 'package:auth_flutter/services/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  String mobile = "";
  String token = "";
  String code = "";
  Future<dynamic> login(String mobile) async {
    var request = Request();
    var result =
        await request.postMethod(url: ConstAPi.login, data: {"mobile": mobile});
    if (result.statusCode == 200) {
      var body = result.data;
      if (body['ok'] == true) {
        token = body['data'];
        this.mobile = mobile;
        return true;
      } else {
        log(body['message']);
        return body['message'];
      }
    } else {
      return "ارسال درخواست با موفقیت انجام نشد کد خطا : ${result.statusCode}";
    }
  }

  Future<dynamic> checkCode(String code) async {
    var request = Request();
    var result = await request.postMethod(
        url: ConstAPi.checkCode, data: {"code": code, "token": token});
    if (result.statusCode == 200) {
      var body = result.data;
      if (body['ok'] == true) {
        this.code = code;
        if (body['data'] == 'register') {
          return 'register';
        }
        setJWT(body['data']);
        return true;
      } else {
        log(body['message']);
        return body['message'];
      }
    } else {
      return "ارسال درخواست با موفقیت انجام نشد کد خطا : ${result.statusCode}";
    }
  }

  Future<dynamic> register(
      {required String firstName, required String lastName}) async {
    var request = Request();
    var result = await request.postMethod(url: ConstAPi.register, data: {
      "code": code,
      "token": token,
      "first_name": firstName,
      "last_name": lastName
    });
    if (result.statusCode == 200) {
      var body = result.data;
      if (body['ok'] == true) {
        setJWT(body['data']);

        return true;
      } else {
        log(body['message']);
        return body['message'];
      }
    } else {
      return "ارسال درخواست با موفقیت انجام نشد کد خطا : ${result.statusCode}";
    }
  }

  Future<UserModel?> me() async {
    var request = Request();
    var result = await request.postMethod(url: ConstAPi.me, sendToken: true);
    if (result.statusCode == 200) {
      var body = result.data;
      return UserModel.fromJson(body['data']);
    } else {
      debugPrint('error in fetch api');
    }

    return null;
  }

  Future logout() async {
    var request = Request();
    await request.postMethod(url: ConstAPi.logout, sendToken: true);
    final box = GetStorage();
    await box.remove('token');
  }

  Future setJWT(String token) async {
    final box = GetStorage();
    box.write('token', token);
  }
}
