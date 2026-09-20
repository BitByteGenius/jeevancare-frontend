import 'package:dio/dio.dart';
import '../../app/constants/app_constants.dart';
import '../errors/app_exceptions.dart';
import 'api_interceptors.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({Dio? dio}) {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: AppConstants.baseApiUrl,
            connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
            receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
          ),
        );
    _dio.interceptors.add(ApiInterceptors());
  }

  Dio get dio => _dio;

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  AppException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkException();
    }
    final statusCode = e.response?.statusCode;
    if (statusCode == 401 || statusCode == 403) {
      return UnauthorizedException();
    }
    if (statusCode == 404) {
      return NotFoundException();
    }
    return ServerException(
      e.response?.data?['message']?.toString() ?? 'An unexpected error occurred',
      statusCode,
    );
  }
}
