class MoodEntry {

  final int? id; // Add the id field
  final DateTime date;
  final String mood;
  final List<String> activities;
  final String? note; // Optional note field

  MoodEntry({
    this.id,
    required this.date,
    required this.mood,
    required this.activities,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'activities': activities.join(', '), // Convert activities list to string
      'note': note, // Include note if not null
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      mood: map['mood'],
      activities: map['activities'].split(', '), // Convert string back to list
      note: map['note'],
    );
  }
}
