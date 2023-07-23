// ignore_for_file: constant_identifier_names

import 'package:weeshr/utilities/constant/exported_packages.dart';

const Color TEAL = Color(0xFF20BC8F);
const Color WHITE = Color(0xFFFFFFFF);

// Primary Scale
const Color PRIMARY_50 = Color(0xFFebbca1);
const Color PRIMARY_100 = Color(0xFFe6ab8a);
const Color PRIMARY_200 = Color(0xFFe19b72);
const Color PRIMARY_300 = Color(0xFFdc8a5b);
const Color PRIMARY_400 = Color(0xFFd67944);
const Color PRIMARY = Color(0xFFB95D28);

// Secondary Scale
const Color SECONDARY = Color(0xFFE7C8A3);

// Grey Scale
const Color GREY_50 = Color(0xFFE1E8EF);
const Color GREY_100 = Color(0xFFd6dbe1);
const Color GREY_200 = Color(0xFFd6dbe1);
const Color GREY_300 = Color(0xFFc9cfd7);
const Color GREY_400 = Color(0xFFbcc3ce);
const Color GREY_500 = Color(0xFFaeb6c4);
const Color GREY_600 = Color(0xFFa1aaba);
const Color GREY_700 = Color(0xFF939eb0);
const Color GREY = Color(0xFF78869C);

// Alert Success Scale
const Color GREEN = Color.fromARGB(255, 12, 208, 84);

// Alert Warning Scale
const Color ORANGE = Color(0xFFEAB308);

// Alert Error Scale
const Color RED = Color(0xFFEF4444);
const Color RED_LIGHT = Color(0xFFFCA5A5);
const Color RED_BASE = Color(0xFFF75555);

// Primary Swatches
const primarySwatches = <int, Color>{
  50: PRIMARY_100,
  100: PRIMARY_100,
  200: PRIMARY_300,
  300: PRIMARY_300,
  400: PRIMARY_400,
  500: PRIMARY,
  600: PRIMARY,
  700: PRIMARY,
  800: PRIMARY,
  900: PRIMARY,
};

// Grey Swatches
const grey = <int, Color>{
  50: GREY_50,
  100: GREY_100,
  200: GREY_200,
  300: GREY_300,
  400: GREY_400,
  500: GREY_500,
  600: GREY_600,
  700: GREY_700,
  900: GREY,
};

// Alert Error Swatches
const alertError = <String, Color>{
  "Light": RED_LIGHT,
  "Base": RED_BASE,
  "Dark": RED,
};

// Alert Warning Swatches
const alertWarning = <String, Color>{
  "Dark": ORANGE,
};

// Alert Success Swatches
const alertSuccess = <String, Color>{
  "Dark": GREEN,
};
