// ignore_for_file: file_names

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:weeshr/core/config/dependencies.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_controller.dart';
import 'package:weeshr/modules/weather/models/weatherModel.dart';
import 'package:weeshr/modules/weather/presentation/components/city_carousel.dart';
import 'package:weeshr/modules/weather/presentation/components/city_filter.dart';
import 'package:weeshr/modules/weather/presentation/components/degree_value.dart';
import 'package:weeshr/modules/weather/presentation/components/weather_item.dart';
import 'package:weeshr/utilities/common/widgets/app_wrapper.dart';
import 'package:weeshr/utilities/common/widgets/custom_loader.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/homeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherController _weatherCtrl;
  WeatherModel _weatherData = const WeatherModel();

  @override
  void initState() {
    _weatherCtrl = locator.get<WeatherController>();
    _weatherData = _weatherCtrl.getCurrentWeatherData;
    // Future.microtask(() => _weatherCtrl.loadSavedCities());
    Future.microtask(() {
      _weatherCtrl.loadSavedCities();
      _weatherCtrl.getUserWeatherData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _weatherCtrl = context.watch<WeatherController>();
    return Wrapper(
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labeltext(
                "${capitalize(_weatherCtrl.headerTitle)} 🌦️ ",
                color: GREY,
              ),
              subtext(
                todayDate(),
                color: GREY_700,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () => _showMandateDialog(context),
            child: const Icon(
              Icons.search,
              color: GREY,
            ),
          ),
        )
      ],
      leading: null,
      leadingWidth: 0,
      body: Stack(
        children: [
          ListView(
            children: [
              ySpace(height: 10),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 28.0),
                      child: DropShadowImage(
                        image: Image.asset(
                          ImageUtils.weather,
                          height: 200,
                        ),
                        offset: const Offset(5, 30),
                        scale: 0.7,
                      ),
                    ),
                  ),
                  const CityCarousel(),
                ],
              ),
              ySpace(),
              if (_weatherCtrl.loading) const Loader(),
              if (!_weatherCtrl.loading) ...[
                DegreeValue(degree: "${_weatherData.main?.temp ?? '18'}"),
                subtext(
                  _weatherData.weather?.first.main ?? "Cloudy",
                  fontSize: 20,
                  color: GREY_500,
                  textAlign: TextAlign.center,
                ),
              ],
              ySpace(),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: WHITE.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 5),
                      color: GREY_50,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _weatherCtrl.loading
                          ? const Loader()
                          : weatherItem(
                              title: "Wind",
                              content:
                                  "${_weatherData.wind?.speed ?? '26'}km/h",
                            ),
                      const VerticalDivider(
                        color: GREY,
                        width: 3,
                      ),
                      _weatherCtrl.loading
                          ? const Loader()
                          : weatherItem(
                              title: "Humidity",
                              content:
                                  "${_weatherData.main?.humidity ?? '90'}%",
                            ),
                      const VerticalDivider(
                        color: GREY,
                        width: 3,
                      ),
                      _weatherCtrl.loading
                          ? const Loader()
                          : weatherItem(
                              title: "Pressure",
                              content:
                                  "${_weatherData.main?.pressure ?? '50'}hPa",
                            ),
                    ],
                  ),
                ),
              ),
              ySpace(),
              labeltext(
                "Today",
              ),
              ySpace(height: 30),
              Stack(
                children: [
                  Image.asset(
                    ImageUtils.spiral,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 20),
                      child: Column(
                        children: [
                          subtext(
                            "12 PM",
                            color: GREY,
                            fontSize: 12,
                          ),
                          Image.asset(
                            ImageUtils.cloudSunny,
                            height: 40,
                          ),
                          const DegreeValue(
                            degree: '18',
                            size: 14,
                            color: GREY,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0, left: 40),
                      child: Column(
                        children: [
                          subtext(
                            "06 PM",
                            color: GREY,
                            fontSize: 12,
                          ),
                          Image.asset(
                            ImageUtils.weather,
                            height: 40,
                          ),
                          const DegreeValue(
                            degree: '21',
                            size: 14,
                            color: GREY,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          subtext(
                            "08 PM",
                            color: GREY,
                            fontSize: 12,
                          ),
                          Image.asset(
                            ImageUtils.cold,
                            height: 40,
                          ),
                          const DegreeValue(
                            degree: '17',
                            size: 14,
                            color: GREY,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              labeltext(
                "Next forecast",
              ),
              const Divider(
                height: 15,
                color: GREY,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subtext(
                        "Tuesday",
                        color: GREY_500,
                      ),
                      subtext(
                        "25:08",
                        fontSize: 12,
                        color: GREY_500,
                      ),
                    ],
                  ),
                  Image.asset(
                    ImageUtils.weather,
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DegreeValue(
                        degree: '17',
                        size: 14,
                        color: GREY,
                      ),
                      xSpace(width: 10),
                      const DegreeValue(
                        degree: '12',
                        size: 14,
                        color: GREY_300,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                _weatherCtrl.addRemoveCity(
                  context: context,
                  add: !_alreadyAdded(),
                  city: _weatherCtrl.getSelectedCity,
                );
              },
              backgroundColor: _alreadyAdded() ? RED : GREEN,
              child: Icon(
                _alreadyAdded() ? Icons.remove : Icons.add,
                color: WHITE,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _alreadyAdded() {
    if (_weatherCtrl.alreadySavedCity) {
      return true;
    }
    return false;
  }

  void _showMandateDialog(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (
            BuildContext ctx,
            StateSetter stateSetter,
          ) {
            return const BottomSheetWrapper(
              closeOnTap: false,
              child: CityFilter(),
            );
          },
        );
      },
    );
  }
}
