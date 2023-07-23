// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:weeshr/core/component/local_storage.dart';
import 'package:weeshr/core/config/dependencies.dart';
import 'package:weeshr/core/exception/app_exceptions.dart';
import 'package:weeshr/core/model/api_response.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_repository.dart';
import 'package:weeshr/utilities/common/utils.dart';

class WeatherService {
  final log = Logger("WeatherService");
  final WeatherRepository weatherRepository;
  final localStorageService = locator.get<LocalStorageService>();

  WeatherService(this.weatherRepository);

  Future<ApiResponse> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      ApiResponse res = ApiResponse(
        code: '200',
        result: await weatherRepository.fetchWeather(lat, lon),
        message: 'Data Gotten',
        isError: false,
      );
      return res;
    } on DioError catch (e) {
      var msg = e.response?.data['message'];
      showError(message: msg);
      log.severe("Error message @fetchWeather ::===> $msg");
      return NetworkException.errorHandler(e);
    }
  }
}
