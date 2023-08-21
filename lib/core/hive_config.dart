import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig {
  static init() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        Directory dir = await getApplicationDocumentsDirectory();
        await Hive.initFlutter(dir.path);
      }
    } catch (e) {
      if (kIsWeb) {
        debugPrint('Running on web ...');
      }
    }
  }
}
