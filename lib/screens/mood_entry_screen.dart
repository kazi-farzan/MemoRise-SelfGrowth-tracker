import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memorise/models/mood_entry.dart';
import 'package:memorise/utils/database_helper.dart';
import 'package:memorise/providers/entry_data_provider.dart';

class MoodEntryScreen extends StatefulWidget {
  @override
  _MoodEntryScreenState createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  String selectedMood = '';
  List<String> selectedActivities = [];
  List<String> moodOptions = [
    '😄 Very Happy',
    '🙂 Happy',
    '😐 Neutral',
    '☹️ Sad',
    '😢 Very Sad',
  ];
  List<String> activityOptions = [
    'Work',
    'Exercise',
    'Socializing',
    'Family',
    'Relaxation',
  ];
  TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EntryDataProvider entryProvider = Provider.of<EntryDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Your Mood:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: moodOptions.map((mood) {
                return ChoiceChip(
                  label: Text(mood),
                  selected: selectedMood == mood,
                  onSelected: (selected) {
                    setState(() {
                      selectedMood = selected ? mood : '';
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a Note (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            Text(
              'Select Activities:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: activityOptions.map((activity) {
                return FilterChip(
                  label: Text(activity),
                  selected: selectedActivities.contains(activity),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedActivities.add(activity);
                      } else {
                        selectedActivities.remove(activity);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (selectedMood.isNotEmpty) {
                  String note = _noteController.text.isNotEmpty ? _noteController.text : '';
                  String currentDate = DateTime.now().toIso8601String();
                  String activities = selectedActivities.join(', ');

                  MoodEntry entry = MoodEntry(
                    date: currentDate,
                    mood: selectedMood,
                    note: note,
                    activities: activities,
                  );

                  DatabaseHelper dbHelper = DatabaseHelper();
                  int id = await dbHelper.insertMoodEntry(entry);
                  print('Inserted mood entry with ID: $id');
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please select a mood.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
