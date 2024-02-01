import 'package:flutter/services.dart';

class FileReader {
  static Future<List<String>> readFileLines(String filePath) async {
    try {
      String fullPath = "lib/assets/input/$filePath";
      String contents = await rootBundle.loadString(fullPath);
      return contents.split('\n');
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }
}