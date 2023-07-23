import 'package:logging/logging.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

abstract class BaseController extends ChangeNotifier {
  final logBasecontroller = Logger("Basecontroller");

  // Values
  bool _busy = false;
  bool _updating = false;
  bool _searching = false;

  // Getters
  bool get loading => _busy;
  bool get updating => _updating;
  bool get searching => _searching;

  // Setters
  setBusy(bool value, {bool when = true}) {
    if (!when) {
      return;
    }
    _busy = value;
    notifyListeners();
  }

  setSearching(bool value) {
    _searching = value;
    notifyListeners();
  }

  setUpdating(bool value) {
    _updating = value;
    notifyListeners();
  }
}
