class MoodEntry {
  final String date;
  final String mood;
  final String note;
  final String activities;

  MoodEntry({
    required this.date,
    required this.mood,
    required this.note,
    required this.activities,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'mood': mood,
      'note': note,
      'activities': activities,
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      date: map['date'],
      mood: map['mood'],
      note: map['note'],
      activities: map['activities'],
    );
  }
}
