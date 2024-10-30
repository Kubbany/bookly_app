import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    if (dioException.error is SocketException) {
      return ServerFailure(
        errorMessage: "No Internet Connection",
      );
    }
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: "Connection timeout with API Server",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: "Send timeout with API Server",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: "Receive timeout with API Server",
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage: "Bad Certificate",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: "Cancelled",
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage: "Connection Error",
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: "Oops, Something Went Wrong, Try Again Later",
        );
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: "Your Request Not Found, Please Try Again!");
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: "Internal Server Error, Please Try Later!");
    } else {
      return ServerFailure(
          errorMessage: "Oops!, There Was An Error, Please Try Again!");
    }
  }
}
