import 'package:dio/dio.dart';
import 'package:weeshr/core/model/api_response.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class NetworkException implements Exception {
  final dynamic msg;

  NetworkException([this.msg]);

  @override
  String toString() => "$msg";

  static ApiResponse errorHandler(DioError e, {BuildContext? context}) {
    if (!isObjectEmpty(e.response)) {
      if (DioErrorType.response == e.type &&
          e.response?.data is Map<String, dynamic>) {
        ApiResponse response = ApiResponse.fromJson(e.response?.data);
        return response;
      }
    }
    throw NetworkException(exceptionHandler(
      e.type,
      e.response?.statusCode,
      ctx: context,
    ));
  }
}

String exceptionHandler(DioErrorType? errorType, int? statusCode,
    {BuildContext? ctx}) {
  if (DioErrorType.connectTimeout == errorType) {
    return "Please check your internet connection and try again!";
  } else if (DioErrorType.receiveTimeout == errorType &&
      DioErrorType.sendTimeout == errorType) {
    return "Your request has been timed out";
  } else if (DioErrorType.response == errorType && statusCode == 401) {
    if (ctx != null) {
      // safeNavigate(() => logout(ctx));
    }
    return "Something went wrong, Please log back in.";
  } else {
    return "Something went wrong, Please try again later!";
  }
}
