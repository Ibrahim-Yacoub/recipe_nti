import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout. Please try again.";
        case DioExceptionType.sendTimeout:
          return "Send timeout. Please try again.";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout. Please try again.";
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response?.statusCode);
        case DioExceptionType.cancel:
          return "Request was cancelled.";
        case DioExceptionType.connectionError:
          return "No internet connection. Please check your network.";
        default:
          return "Something went wrong. Please try again.";
      }
    } else {
      return "Unexpected error occurred.";
    }
  }

  static String _handleBadResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Forbidden. You don't have permission.";
      case 404:
        return "Not found.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}

