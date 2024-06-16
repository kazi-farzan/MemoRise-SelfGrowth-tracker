import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:memorise/providers/entry_data_provider.dart'; // Adjust path as per your project structure
import 'package:memorise/models/journal_entry.dart'; // Adjust path as per your project structure

class CalendarViewScreen extends StatefulWidget {
  @override
  _CalendarViewScreenState createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Access the EntryDataProvider instance
  late EntryDataProvider entryProvider;

  @override
  void didChangeDependencies() {
    entryProvider = Provider.of<EntryDataProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  // Example mood data (replace with actual data from your app)
  Map<DateTime, List<String>> _moodEntries = {
    DateTime.utc(2023, 6, 14): ['happy'],
    DateTime.utc(2023, 6, 15): ['sad'],
    DateTime.utc(2023, 6, 16): ['neutral'],
    // Add more entries here
  };

  Color _getColorForMood(String mood) {
    switch (mood) {
      case 'happy':
        return Colors.green;
      case 'sad':
        return Colors.blue;
      case 'neutral':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        currentIndex: 1, // Current index of Calendar screen
        selectedItemColor: Colors.blue, // Adjust color as needed
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/dashboard');
              break;
            case 1:
            // Stay on Calendar screen
              break;
            case 2:
              Navigator.pushNamed(context, '/journal');
              break;
            case 3:
              Navigator.pushNamed(context, '/statistics');
              break;
            case 4:
              _navigateToMoodEntryScreen();
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                // Optionally show detailed mood entry for the selected day
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_moodEntries.containsKey(day)) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getColorForMood(_moodEntries[day]!.first),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _selectedDay != null
                  ? _buildMoodDetails()
                  : Center(child: Text('Select a day to see details')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToMoodEntryScreen,
        tooltip: 'Add Journal Entry',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMoodDetails() {
    List<String> moods = _moodEntries[_selectedDay!] ?? [];
    return ListView(
      children: [
        Text(
          'Mood for ${_selectedDay!.toLocal()}',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        ...moods.map((mood) => ListTile(
          leading: Icon(Icons.mood, color: _getColorForMood(mood)),
          title: Text(mood),
        )),
        // Add notes and activities here if needed
      ],
    );
  }

  void _navigateToMoodEntryScreen() {
    Navigator.pushNamed(context, '/mood_entry');
  }
}
