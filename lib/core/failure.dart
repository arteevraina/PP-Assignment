import 'package:dio/dio.dart';

/// A class for managing the exceptions thrown by the [Dio] library.
class Failure implements Exception {
  String message = "";

  Failure({required this.message});

  Failure.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = "Received invalid response from API server";
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Error in Internet connection";
        break;
    }
  }

  @override
  String toString() => message;
}
