import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class HiveHelper {
  static const String _boxName = 'swifty-companion';

  static Future<String> getAppDirectory() async{
    if(kIsWeb){
      return '/';
    }else{
      final appDocumentDir = await getApplicationDocumentsDirectory();
      return appDocumentDir.path;
    }
  }
  
  // Initialize Hive
  static Future<void> init() async {
    
    final appDocumentDir = await getAppDirectory();
      Hive.init(appDocumentDir);
    
    await Hive.openBox(_boxName);
  }
  
  // Add item by name
  static Future<void> add(String name, dynamic value) async {
    final box = Hive.box(_boxName);
    await box.put(name, value);
  }
  
  // Get item by name
  static dynamic get(String name) {
    final box = Hive.box(_boxName);
    return box.get(name);
  }
  
  // Clear hive
  static Future<void> clearHive() async {
    final box = Hive.box(_boxName);
    await box.clear();
  }
}