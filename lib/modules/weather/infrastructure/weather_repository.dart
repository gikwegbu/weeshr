// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weeshr/core/config/env.config.dart';
import 'package:weeshr/modules/weather/models/weatherModel.dart';

part 'weather_repository.g.dart';

class WeatherApis {
  static const baseApi = API_ENDPOINT;
  // static const fetchWeather = "$baseApi/data/2.5/weather?lat=44.34&lon=10.99&appid={API key}";
  static const fetchWeather =
      "$baseApi/data/2.5/weather?lat={lat}&lon={lon}&appid=$API_KEY";
}

@RestApi()
abstract class WeatherRepository {
  factory WeatherRepository(Dio dio, {String? baseUrl}) = _WeatherRepository;

  @POST(WeatherApis.fetchWeather)
  Future<WeatherModel> fetchWeather(
    @Path('lat') double lat,
    @Path('lon') double lon,
  );
}
