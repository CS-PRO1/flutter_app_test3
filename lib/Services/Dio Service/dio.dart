import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(baseUrl: 'https://student.valuxapps.com/api/', headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
    }));
  }

  static Future<Response?> getData(String url,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio?.get(url, queryParameters: query);
  }



  static Future<Response?> postData(String url, Map<String, dynamic> body,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio?.post(url, data: body, queryParameters: query);
  }



  static Future<Response?> putData(String url, Map<String, dynamic> body,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio?.put(url, data: body, queryParameters: query);
  }
}
