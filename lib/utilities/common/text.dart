import 'package:flutter/material.dart';
import 'package:weeshr/utilities/constant/colors.dart';

Text labeltext(
  String label, {
  Color? color,
  TextAlign? textAlign,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? overflow,
  double? letterSpacing,
}) {
  return Text(
    label,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    overflow: overflow,
    softWrap: true,
    style: TextStyle(
      color: color ?? GREY,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? 16,
      letterSpacing: letterSpacing,
      fontFamily: 'Roboto',
    ),
  );
}

Text titletext(String label, {TextAlign? textAlign}) {
  return labeltext(
    label,
    fontWeight: FontWeight.w600,
    // fontSize: 18,
    fontSize: 20,
    textAlign: textAlign,
  );
}

Text subtext(
  String label, {
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  TextDecoration? textDecoration,
  double? fontSize,
  int? maxLines,
  TextOverflow? overflow,
  double height = 1.2,
}) {
  return Text(
    label,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    softWrap: true,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      color: color ?? const Color(0xFFFFFFFF),
      fontSize: fontSize ?? 15,
      fontWeight: fontWeight ?? FontWeight.w400,
      decoration: textDecoration,
      height: height,
      fontFamily: 'Roboto',
    ),
  );
}
