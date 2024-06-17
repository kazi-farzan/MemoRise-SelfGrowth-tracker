import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  List<String> moodOptionsEmoji = [
    '😄',
    '🙂',
    '😐',
    '☹️',
    '😢',
  ];

  List<String> activityOptions = [
    'Work',
    'Exercise',
    'Socializing',
    'Family',
    'Relaxation',
  ];
  TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EntryDataProvider entryProvider =
    Provider.of<EntryDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Entry'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              Wrap(
                spacing: 10.0,
                children: List.generate(moodOptions.length, (index) {
                  return SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedMood == moodOptions[index]) {
                            selectedMood = '';
                          } else {
                            selectedMood = moodOptions[index];
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ), backgroundColor: selectedMood == moodOptions[index]
                            ? Colors.blue // Change color for selected mood
                            : null,
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Text(
                        moodOptionsEmoji[index],
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.0),
              Text(
                'Select Activities:',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  _buildActivitySection("Emotions", [
                    'Happy',
                    'Excited',
                    'Grateful',
                    'Relaxed',
                    'Content',
                    'Tired',
                    'Unsure',
                    'Bored',
                    'Anxious',
                    'Angry',
                    'Stressed',
                    'Sad',
                    'Desperate'
                  ]),
                  _buildActivitySection("Sleep", [
                    'Slept early',
                    'Good sleep',
                    'Medium sleep',
                    'Bad sleep'
                  ]),
                  _buildActivitySection("Health", [
                    'Exercise',
                    'Eat healthy',
                    'Drink water',
                    'Walk'
                  ]),
                  _buildActivitySection("Hobbies", [
                    'Reading',
                    'Gaming',
                    'Sport',
                    'Relax'
                  ]),
                  _buildActivitySection("Food", [
                    'Fast food',
                    'Homemade',
                    'Restaurant',
                    'Delivery'
                  ]),
                  _buildActivitySection("Social", [
                    'Family',
                    'Friends',
                    'Date',
                    'Party'
                  ]),
                  _buildActivitySection("Better Me", [
                    'Meditation',
                    'Kindness',
                    'Listen',
                    'Donate',
                    'Give gift'
                  ]),
                  _buildActivitySection("Productivity", [
                    'Start early',
                    'Make list',
                    'Focus',
                    'Take a break'
                  ]),
                  _buildActivitySection("Chores", [
                    'Shopping',
                    'Cleaning',
                    'Cooking',
                    'Laundry'
                  ]),
                  _buildActivitySection("School", [
                    'Study',
                    'Homework',
                    'Exam',
                    'Group project',
                    'Class',
                    'Personal project'
                  ]),
                  _buildActivitySection("Beauty", [
                    'Haircut',
                    'Wellness',
                    'Massage',
                    'Manicure',
                    'Pedicure',
                    'Skin care',
                    'Spa'
                  ]),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date of Entry:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      DateFormat('EEE, MMM d, yyyy').format(selectedDate),
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    ),
                  ),
                ],
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
              ElevatedButton(
                onPressed: () async {
                  if (selectedMood.isNotEmpty) {
                    String? note =
                    _noteController.text.isNotEmpty ? _noteController.text : null;
                    List<String> activities = List.from(selectedActivities);

                    MoodEntry entry = MoodEntry(
                      date: selectedDate,
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
      ),
    );
  }

  Widget _buildActivitySection(String title, List<String> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 10.0,
          children: activities.map((activity) {
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
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
