import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add default headers, auth tokens if available
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    
    if (kDebugMode) {
      debugPrint('[DIO REQUEST] ${options.method} -> ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO RESPONSE] ${response.statusCode} <- ${response.requestOptions.uri}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO ERROR] ${err.response?.statusCode} -> ${err.message}');
    }
    super.onError(err, handler);
  }
}
