import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

class DioManager {
  Dio? dio;
  CookieJar? cookieJar;

  static DioManager? _instance;

  DioManager._internal() {
    dio = Dio();
    cookieJar = CookieJar();
    BaseOptions option = dio!.options;

    dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers.addAll({
        'X-RapidAPI-Key': '5c00a5b94amshae93e6a47655473p16ed3fjsn7008de71369e',
        'X-RapidAPI-Host': "moviesdatabase.p.rapidapi.com",
        'Content-Type': 'application/json',
        'accept': 'application/json',
      });

      return handler.next(options);
    }, onResponse: (response, handler) {
      if (response.data['success'] == false) {
        return handler.reject(
          DioError(
            requestOptions: RequestOptions(path: response.requestOptions.path),
            error: response.data['message'],
          ),
        );
      }

      if (response.data['error_code'] == '0001' ||
          response.data['error_code'] == '0002' ||
          response.data['error_code'] == '0004' ||
          response.data['error_code'] == '0006' ||
          response.data['error_code'] == '0400') {
        return handler.reject(
          DioError(
            requestOptions: RequestOptions(path: response.requestOptions.path),
            error: response.data['error_message'],
          ),
        );
      }

      debugPrint(
        'dio_manager statusCode: ${response.statusCode}, baseUrl: ${response.requestOptions.baseUrl}, path: ${response.requestOptions.path}',
      );

      debugPrint('dio_manager response => data: ${response.data}');

      return handler.next(response);
    }, onError: (DioError e, handler) async {
      debugPrint(
        'dio_manager statusCode: ${e.response?.statusCode}, baseUrl: ${e.response?.requestOptions.baseUrl}, path: ${e.response?.requestOptions.path}',
      );

      debugPrint('dio_manager message => data: ${e.response?.data}');


      return handler.reject(e);
    }));

    option.baseUrl = 'https://moviesdatabase.p.rapidapi.com/';
    option.connectTimeout = const Duration(seconds: 10);
    option.receiveTimeout = const Duration(seconds: 10);
    dio!.interceptors.add(CookieManager(cookieJar!));
  }

  static DioManager getInstance() {
    _instance ??= DioManager._internal();

    return _instance!;
  }

  static Dio getDio() {
    return getInstance().dio!;
  }
}