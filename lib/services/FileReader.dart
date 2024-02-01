import 'package:flutter/services.dart';

class FileReader {
  static Future<List<String>> readFileLines(String filePath) async {
    try {
      String contents = await rootBundle.loadString(filePath);
      return contents.split('\n');
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }
}