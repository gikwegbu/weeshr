// ignore_for_file: non_constant_identifier_names

import 'package:weeshr/utilities/constant/exported_packages.dart';

ThemeData LIGHT_THEME = ThemeData(
  primarySwatch: const MaterialColor(0xFF21214E, primarySwatches),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  fontFamily: FontFamily,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: PRIMARY,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY,
      elevation: .3,
    ),
  ),
);

ThemeData DARK_THEME = ThemeData(
  primarySwatch: const MaterialColor(0xFF21214E, primarySwatches),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  fontFamily: FontFamily,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: PRIMARY,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY,
      elevation: .3,
    ),
  ),
);
