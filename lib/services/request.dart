import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class Request {
  Future<dynamic> getMethod(
      {required String url,
      Object? data,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    var dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    var response = await dio.get(url,
        data: data, options: options, queryParameters: queryParameters);
    return response;
  }

  Future<dynamic> postMethod(
      {required String url,
      Object? data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      bool sendToken = false}) async {
    var dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    if (sendToken) {
      final box = GetStorage();
      String token = box.read('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    var response = await dio.post(url,
        data: data, options: options, queryParameters: queryParameters);
    return response;
  }
}
