import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  final _box = Hive.box(KeyString.weeshrDb);
  final logger = Logger('Local Storage Service::');
  final FlutterSecureStorage storage;

  LocalStorageService(this.storage);

  static Future<void> initializeDb() async {
    await Hive.initFlutter();
    await Hive.openBox(KeyString.weeshrDb);
    Logger.root.info("Initialized weeshr HIVE:::::::");
  }

  dynamic saveData(String key, dynamic data) async {
    if (getData(key) != null) {
      logger.info("Deleting $key record from HIVE:::");
      await remove(key);
    }
    await _saveData(key, data);
    logger.info("Saved $key with data $data");
    return data;
  }

  dynamic getData(String key) {
    return _box.get(key);
  }

  Future<void> remove(String key) async {
    if (getData(key)! - null) {
      await _box.delete(key);
    }
  }

  _saveData(String key, dynamic data) async {
    await _box.put(key, data);
  }

  dynamic saveJsonData(String key, dynamic data) async {
    if (getData(key) != null) {
      logger.info("Deleting $key record from HIVE:::");
      await remove(key);
    }
    await _saveData(key, jsonEncode(data));
    logger.info("Saved $key with data $data");
    return data;
  }

  dynamic getJsonData(String key) {
    var data = getData(key);
    return (data != null) ? jsonDecode(data) : null;
  }

  dynamic getDynamicData(String key, bool isJson) {
    return isJson ? getJsonData(key) : getData(key);
  }

  Future<void> saveSecureJson(String key, dynamic data) async {
    if (Platform.isIOS) {
      const options =
          IOSOptions(accessibility: KeychainAccessibility.first_unlock);
      await storage.write(key: key, value: jsonEncode(data), iOptions: options);
      logger.info("Saved secured record with key $key");
      return;
    }
    logger.info("Saved secured record with key $key");
    await storage.write(key: key, value: jsonEncode(data));
  }

  Future<dynamic> getSecureJson(String key) async {
    var data = await storage.read(key: key);
    return isNotEmpty(data) ? jsonDecode(data!) : null;
  }

  Future<void> deleteSecureJson(String key) async {
    var data = await storage.read(key: key);
    if (isNotEmpty(data)) {
      await storage.delete(key: key);
      logger.info("Deleted secured $key record");
    }
  }

  Future<void> saveSecure(String key, String data) async {
    if (Platform.isIOS) {
      const options =
          IOSOptions(accessibility: KeychainAccessibility.first_unlock);
      await storage.write(key: key, value: data, iOptions: options);
      logger.info("Saved secured $key record");
      return;
    }
    await storage.write(key: key, value: data);
    logger.info("Saved secured $key record");
  }

  Future<dynamic> getSecure(String key) async {
    var value = await storage.read(key: key);
    return isNotEmpty(value) ? value : null;
  }

  Future<void> deleteSecure(String key) async {
    var value = await storage.read(key: key);
    if (isNotEmpty(value)) {
      await storage.delete(key: key);
      logger.info("Deleted secured record with key $key");
    }
  }
}
