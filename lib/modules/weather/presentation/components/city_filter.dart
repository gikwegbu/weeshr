import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:weeshr/core/config/dependencies.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_controller.dart';
import 'package:weeshr/modules/weather/models/city.dart';
import 'package:weeshr/utilities/common/widgets/input_field.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class CityFilter extends StatefulWidget {
  const CityFilter({Key? key}) : super(key: key);

  @override
  State<CityFilter> createState() => _CityFilterState();
}

class _CityFilterState extends State<CityFilter> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchCity = '';
  late WeatherController _weatherCtrl;

  @override
  void initState() {
    _weatherCtrl = locator.get<WeatherController>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _weatherCtrl.filteredCityListData('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _weatherCtrl = context.watch<WeatherController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderTextField(
          name: "search",
          decoration: FormUtils.formDecoration(
            labelText: Constants.search,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10),
              child: Icon(
                Icons.search,
                size: 24,
                color: GREY,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          style: FORM_STYLE,
          controller: _searchCtrl,
          inputFormatters: [
            length15(),
          ],
          onChanged: (String? value) {
            _weatherCtrl.filteredCityListData(value);
            _searchCity = trimValue(value).toString();
            setState(() {});
          },
        ),
        FormUtils.formSpacer(),
        SizedBox(
          height: screenHeight(context) * .5,
          child: isObjectEmpty(_weatherCtrl.getCityListData)
              ? Center(
                  child: Wrap(
                    spacing: 2,
                    children: [
                      labeltext("Oops!"),
                      labeltext(
                        _searchCity,
                        color: GREEN,
                        textAlign: TextAlign.center,
                      ),
                      labeltext("not available"),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _weatherCtrl.getCityListData.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (_, index) {
                    final City _city = _weatherCtrl.getCityListData[index];
                    bool _isSelected = _weatherCtrl.getSelectedCity == _city;
                    return InkWell(
                      onTap: () => _fetchData(city: _city),
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 20,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: GREY_50,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: labeltext(
                                "${_city.name}",
                              ),
                            ),
                            if (_isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: GREEN,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => ySpace(height: 1),
                ),
        ),
      ],
    );
  }

  void _fetchData({
    required City city,
  }) async {
    navigateBack(context);
    _weatherCtrl.setSelectedCity(city);
    // Call the api here...
    await _weatherCtrl.fetchWeather(
      latitude: city.lat as double,
      longitude: city.lng as double,
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
}
