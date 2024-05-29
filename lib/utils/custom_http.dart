import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomHttp {
  static final Dio _dio = Dio();

  static setInterceptor({String? hash}) {
    if (kDebugMode) {
      print("Intercept called...............");
      print(hash);
    }
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers["Content-Type"] = "application/json";

        if (hash != null) options.headers["Security-Hash"] = hash;
        options.connectTimeout = const Duration(milliseconds: 25000);
        options.receiveTimeout = const Duration(milliseconds: 20000);
        options.sendTimeout = const Duration(milliseconds: 1000);

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.resolve(response);
      },
      onError: (error, handler) async {
        debugPrint('!----------Error-----------!');
        debugPrint(error.response.toString());
        debugPrint('!--------------------------!');

        return handler.next(error);
      },
    ));
  }

  static Dio getDio() {
    return _dio;
  }
}
