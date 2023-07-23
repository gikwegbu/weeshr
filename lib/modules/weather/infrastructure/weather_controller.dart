// ignore_for_file: unused_field, unused_element, prefer_final_fields

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:weeshr/core/component/base_controller.dart';
import 'package:weeshr/core/component/local_storage.dart';
import 'package:weeshr/core/exception/app_exceptions.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_service.dart';
import 'package:weeshr/modules/weather/models/city.dart';
import 'package:weeshr/modules/weather/models/current_session.dart';
import 'package:weeshr/modules/weather/models/weatherModel.dart';
import 'package:weeshr/modules/weather/presentation/components/city_data.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class WeatherController extends BaseController {
  final log = Logger('WeatherController');

  final WeatherService _weatherService;
  final LocalStorageService _storageService;

  WeatherController(
    this._weatherService,
    this._storageService,
  );

  // Variables Starts here
  CurrentSession _session = const CurrentSession();
  int _activeCityIndex = 0;
  List<City> _filteredCities = <City>[];
  City _selectedCity = const City();
  WeatherModel _currentWeatherData = const WeatherModel();

  List<City> _savedCities = <City>[
    const City(),
    const City(
      name: "Lagos",
      lat: 6.4550,
      lng: 6.4550,
    ),
    const City(
      name: "Kano",
      lat: 12.0000,
      lng: 12.0000,
    ),
    const City(
      name: "Abuja",
      lat: 9.0667,
      lng: 9.0667,
    ),
  ];

  // Variables Ends here

  // Getters Starts here
  List<City> get getCityListData => _filteredCities;
  filteredCityListData(String? city) {
    var _ = city?.trim() ?? '';
    _filteredCities = _.isEmpty
        ? cityListData
        : cityListData
            .where((element) =>
                element.name!.toLowerCase().contains(_.toLowerCase()) &&
                element.name!.toLowerCase().startsWith(_.toLowerCase()))
            .toList();
    notifyListeners();
  }

  WeatherModel get getCurrentWeatherData => _currentWeatherData;

  int get activeCityIndex => _activeCityIndex;

  bool get alreadySavedCity {
    if (_activeCityIndex == 0) return false;
    return _savedCities.contains(_savedCities[_activeCityIndex]);
  }

  City get getSelectedCity => _selectedCity;

  Future<List<City>?> get getSavedCities async {
    var _ = await _storageService.getSecureJson(KeyString.savedCities);
    // If not null, means, an array of cities have been saved.
    // then, return the current default cities, concatenated with the newly saved cities.
    // else, just return the default cities only.
    return (_ != null)
        // ? [..._savedCities, ...const City().fromList(_)]
        ? [...const City().fromList(_)]
        : _savedCities;
  }

  // Getters Ends here

  // Setters Starts here

  setAcitveCityIndex(int index) {
    _activeCityIndex = index;
    notifyListeners();
  }

  setSelectedCity(City city) {
    _selectedCity = city;
    setAcitveCityIndex(0);
    notifyListeners();
  }

  resetSelectedCity() {
    _selectedCity = const City();
    notifyListeners();
  }

  set setCurrentWeatherData(WeatherModel weather) {
    _currentWeatherData = weather;
    notifyListeners();
  }

  addRemoveCity({
    required BuildContext context,
    required bool add,
    required City city,
  }) async {
    bool _escapeDelete = [null, "Lagos", "Kano", "Abuja"].contains(city.name);
    print("George this is the ${city.name}");
    bool _alreadyAdded = _savedCities.contains(city);
    if (_escapeDelete) {
      // Remember to effect this...
      showError(message: "Can't delete this record.");
      return;
    }
    if (add) {
      _alreadyAdded
          ? showText(message: "Already Saved")
          : _savedCities.add(city);
    } else {
      // clearSavedCities();
      DialogAction _res = await showAlertDialog(
        context,
        body: labeltext(
          'Are you sure you want to delete ${city.name} weather record?',
          color: GREY_500,
          fontWeight: FontWeight.w400,
        ),
      );
      if (_res == DialogAction.yes) {
        _savedCities.remove(city);
        showSuccess(message: "${city.name} record deleted.");
      }
    }
    // print("George this is the savedCities;:: $_savedCities");
    await _storageService.saveSecureJson(KeyString.savedCities, _savedCities);
    notifyListeners();
  }

  clearSavedCities() async {
    await _storageService.deleteSecure(KeyString.savedCities);
    notifyListeners();
  }

  ///
  // Setters Ends here

  // Functions Starts here

  Future<bool> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    setBusy(true);
    try {
      final response = await _weatherService.fetchWeather(
        lat: latitude,
        lon: longitude,
      );
      if (response.isError) {
        showError(message: "${response.description}");
        return false;
      }
      if (!isObjectEmpty(response.result)) {
        final _resData = response.result as WeatherModel;
        setCurrentWeatherData = _resData;
      }
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  // Functions Ends here
}
