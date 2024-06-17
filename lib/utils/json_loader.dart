import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:memorise/models/mood_entry.dart';

class JsonLoader {
  static Future<List<MoodEntry>> loadSampleEntries() async {
    final String response = await rootBundle.loadString('assets/data/sample_entries.json');
    final List<dynamic> data = json.decode(response);
    return data.map((entry) => MoodEntry.fromMap(entry)).toList();
  }
}
