import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weeshr/core/component/local_storage.dart';
import 'package:weeshr/core/interceptor/http_dio_interceptor.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_controller.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_repository.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_service.dart';

import 'env.config.dart' as env;

final locator = GetIt.instance;
const baseUrl = env.API_ENDPOINT;

void setupLocator() {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  locator.registerSingleton<LocalStorageService>(
      LocalStorageService(locator.get<FlutterSecureStorage>()));
  locator.registerSingleton<HttpDioInterceptors>(HttpDioInterceptors());
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<WeatherRepository>(
    WeatherRepository(
      dioConfig(),
    ),
  );

  // services
  locator.registerSingleton<WeatherService>(
    WeatherService(
      locator.get<WeatherRepository>(),
    ),
  );

  // controller
  locator.registerSingleton<WeatherController>(
    WeatherController(
      locator.get<WeatherService>(),
      locator.get<LocalStorageService>(),
    ),
  );
}

Dio dioConfig() {
  Dio dio = locator<Dio>();
  dio.interceptors.add(locator<HttpDioInterceptors>());

  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 20000;
  dio.options.sendTimeout = 10000;

  return dio;
}
