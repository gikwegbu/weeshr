import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:weeshr/core/component/local_storage.dart';
import 'package:weeshr/modules/weather/infrastructure/weather_controller.dart';
import 'package:weeshr/modules/weather/presentation/screen/Home.dart';
import 'package:weeshr/utilities/constant/constant_strings.dart';

import 'core/config/dependencies.dart';
import 'core/config/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initializeDb();
  setupLocator();
  _setupLogging();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator.get<WeatherController>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const HomeScreen(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) async {
    var log =
        '${rec.level.name}: ${rec.time} <:::::> [${rec.loggerName}] ${rec.sequenceNumber} : ${rec.message}';
    debugPrint(log);
  });
}

void logError(String code, String? message) {
  if (message != null) {
    debugPrint('Weeshr Error: $code\n Error Message: $message');
  } else {
    debugPrint('Weeshr Error: $code');
  }
}
