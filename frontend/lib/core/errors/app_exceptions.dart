class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Network connection error. Please check your internet.']);
}

class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred. Please try again later.', super.statusCode]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = 'Session expired. Please log in again.']);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = 'Requested resource was not found.']);
}
