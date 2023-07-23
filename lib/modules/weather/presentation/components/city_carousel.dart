import 'package:weeshr/core/config/dependencies.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_controller.dart';
import 'package:weeshr/modules/weather/models/city.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class CityCarousel extends StatefulWidget {
  const CityCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<CityCarousel> createState() => _CityCarouselState();
}

class _CityCarouselState extends State<CityCarousel> {
  late WeatherController _weatherCtrl;

  @override
  void initState() {
    _weatherCtrl = locator.get<WeatherController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _weatherCtrl = context.watch<WeatherController>();
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _weatherCtrl.getSavedCities,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return labeltext("${snapshot.error} occurred");
                  } else if (snapshot.hasData) {
                    final List<City> _savedCityList =
                        snapshot.data as List<City>;
                    return ListView.separated(
                      itemCount: _savedCityList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        City _city = _savedCityList[index];
                        bool _isActive =
                            _weatherCtrl.activeCityIndex == index ||
                                _weatherCtrl.getSelectedCity == _city;
                        return isObjectEmpty(_city.name)
                            ? Container()
                            : InkWell(
                                radius: 10,
                                onTap: () => _fetchData(
                                  index: index,
                                  city: _city,
                                ),
                                child: AnimatedContainer(
                                  duration: screenDuration,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _isActive ? GREEN : WHITE,
                                    border: Border.all(
                                      width: 1,
                                      color: GREY_50,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: labeltext(
                                    "${_city.name}",
                                    color: _isActive ? WHITE : GREY,
                                  ),
                                ),
                              );
                      },
                      separatorBuilder: (context, index) => xSpace(width: 15),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _fetchData({
    required int index,
    required City city,
  }) async {
    _weatherCtrl.resetSelectedCity();
    _weatherCtrl.setAcitveCityIndex(index);
    // Call the api here...
    await _weatherCtrl.fetchWeather(
      latitude: city.lat as double,
      longitude: city.lng as double,
    );
  }
}
