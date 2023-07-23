// ignore_for_file: constant_identifier_names, implementation_imports, non_constant_identifier_names

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bot_toast/src/toast.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

const FontFamily = "SF-Pro";

// Default Delay
Duration get screenDuration => const Duration(milliseconds: 200);

// Width of the current Screen Context
double screenWidth(context) => MediaQuery.of(context).size.width;

// Height of the current Screen Context
double screenHeight(context) => MediaQuery.of(context).size.height;

// Used to get a consistent Screen Padding
EdgeInsetsGeometry get screenPadding =>
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0);

// Used to give vertical Spaces
SizedBox ySpace({double? height}) {
  return SizedBox(height: height ?? 30);
}

// Used to give horizontal Spaces
SizedBox xSpace({double? width}) {
  return SizedBox(width: width ?? 30);
}

// To close input field KeyPad
closeKeyPad(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

// Time/Date Formatters
String formatDateOnly(DateTime now) => DateFormat.yMMMEd().format(now);

todayDate() => formatDateOnly(DateTime.now());
// Routing Configs
navigateTo(BuildContext context, String route, {dynamic arguments}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

navigateAndClearAll(BuildContext context, String route,
    {String? secondRoute, dynamic arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      route, ModalRoute.withName(secondRoute ?? '/'),
      arguments: arguments);
}

navigateAndClearPrev(BuildContext context, String route, {dynamic arguments}) {
  Navigator.of(context).popAndPushNamed(route, arguments: arguments);
}

navigateBack(BuildContext context) {
  Navigator.pop(context);
}

// Various State checkers
isEmpty(String? val) {
  return (val == null) || (val.trim().isEmpty);
}

isNotEmpty(String? val) {
  return !isEmpty(val);
}

isObjectEmpty(dynamic val) {
  if (val is Map) return val.isEmpty;
  if (val is List) return val.isEmpty;
  if (val is String) return isEmpty(val);
  return (val == null);
}

String? trimValue(String? val) {
  return isNotEmpty(val) ? val!.trim() : null;
}

String capitalize(String s) {
  List<String> names = s.split(' ');
  if (names.isNotEmpty) {
    return names
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }
  return s;
}

// Notification BotToast
enum _AlertType { error, success, message }

showNotification(
    {required String message,
    required Duration duration,
    GestureTapCallback? onTap}) {
  BotToast.showSimpleNotification(
      title: message, duration: duration, onTap: onTap);
}

showText({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.message, d: duration);
}

_showAlert(String message, _AlertType alert, {Duration? d}) {
  var bgColor = GREY;
  var duration = d ?? const Duration(seconds: 2);

  switch (alert) {
    case _AlertType.error:
      bgColor = RED;
      duration = d ?? const Duration(seconds: 3);
      break;
    case _AlertType.success:
      bgColor = GREEN;
      break;
    default:
      break;
  }
  BotToast.showText(
    text: message,
    contentColor: bgColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    textStyle: const TextStyle(fontSize: 13.0, color: WHITE),
    duration: duration,
  );
}

showSuccess({required String message}) {
  _showAlert(message, _AlertType.success);
}

showError({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.error, d: duration);
}

String errorMessageToString(List<String>? message) {
  return isObjectEmpty(message)
      ? 'Sever error occurred. Please try again later'
      : message!.join("\n");
}

// Custom Loader
weeshrLoader() {
  BotToast.showCustomLoading(
    backgroundColor: Colors.white70,
    toastBuilder: (_) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        // Lottie.asset(ImageUtils.weeshrLoader, height: 80),
      ],
    ),
  );
}

enum DialogAction { yes, cancel }

Future<DialogAction> showAlertDialog(
  BuildContext context, {
  String? title,
  required Widget body,
  bool withButton = true,
  bool withCancel = true,
  Widget? button,
  String? cancelTitle,
  String? okTitle,
  Color? okColor = RED,
  Color? cancelColor = GREY_500,
}) async {
  final action = await showPlatformDialog(
    context: context,
    androidBarrierDismissible: false,
    builder: (_) => BasicDialogAlert(
      title: labeltext(
        title ?? "Confirmation",
        color: GREY,
        fontWeight: FontWeight.bold,
      ),
      content: body,
      actions: <Widget>[
        if (withCancel)
          BasicDialogAction(
            title: Text(
              cancelTitle ?? Constants.cancel,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: cancelColor,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
          ),
        BasicDialogAction(
          title: Text(
            okTitle ?? Constants.ok,
            textScaleFactor: 1.0,
            style: TextStyle(
              color: okColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(DialogAction.yes),
        ),
      ],
    ),
  );
  return (action != null) ? action : DialogAction.cancel;
}

Future checkPermission() async {
  final status = await Permission.storage.status;
  if ((status == PermissionStatus.permanentlyDenied) ||
      (status == PermissionStatus.restricted)) {
    openAppSettings();
    return false;
  }
  if (status != PermissionStatus.granted) {
    final result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

String enumToString<T>(T value, {camelCase = false}) =>
    EnumToString.convertToString(value, camelCase: camelCase);
List<String> enumToListString<T>(T value, {camelCase = false}) =>
    enumToListString(value);

length15() => FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$'));
