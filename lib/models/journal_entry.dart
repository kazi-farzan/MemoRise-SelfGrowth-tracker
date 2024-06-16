import 'package:flutter/foundation.dart';

class JournalEntry {
  final DateTime date;
  final String mood;
  final String? note;
  final List<String> activities;

  JournalEntry({
    required this.date,
    required this.mood,
    this.note,
    this.activities = const [],
  });

  // Getter for moodEmoji
  String get moodEmoji {
    // Implement logic to return emoji based on mood
    switch (mood) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'angry':
        return '😡';
    // Add more cases as needed
      default:
        return '😐'; // Default emoji
    }
  }

  // Getter for notes
  String get notes => note ?? ''; // Returns empty string if note is null
}
