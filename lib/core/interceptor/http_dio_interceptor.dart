import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class HttpDioInterceptors extends InterceptorsWrapper {
  final weeshrLogger = Logger("HttpDioInterceptor");

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    options.headers["content-type"] = 'application/json';
    options.headers["accept"] = 'application/json';

    weeshrLogger.info("REQUEST DATA ${options.baseUrl}");
    weeshrLogger.info("REQUEST DATA ${options.uri.toString()}");
    weeshrLogger.info("REQUEST DATA ${options.path}");
    weeshrLogger.info("REQUEST DATA ${options.headers}");
    weeshrLogger.info("REQUEST DATA ${options.data}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
