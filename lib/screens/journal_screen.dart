import 'package:flutter/material.dart';
import 'package:memorise/models/mood_entry.dart';
import 'package:memorise/utils/database_helper.dart';
import 'package:intl/intl.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<MoodEntry> _entries = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      List<MoodEntry> entries = await dbHelper.getAllMoodEntries();
      entries.sort((a, b) => b.date.compareTo(a.date)); // Sort entries by newest first
      setState(() {
        _entries = entries;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteEntry(int id) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.deleteMoodEntry(id);
    _loadEntries(); // Refresh entries after deletion
  }

  void _confirmDelete(BuildContext context, MoodEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await _deleteEntry(entry.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEntryCard(BuildContext context, MoodEntry entry) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column 1: Emoji for mood
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  _getEmojiForMood(entry.mood),
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
            ),
            SizedBox(width: 10.0),

            // Column 2: Details
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Date and Time
                  if (entry.date != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMd().add_jm().format(entry.date),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(context, entry);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                  ],

                  // Row 2: Entry Text
                  if (entry.note != null && entry.note!.isNotEmpty) ...[
                    Text(
                      entry.note!,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 10.0),
                  ],

                  // Row 3: Activities as tags
                  Wrap(
                    spacing: 5.0,
                    runSpacing: -8.0,
                    children: entry.activities.map((activity) {
                      return Chip(
                        label: Text(activity),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmojiForMood(String mood) {
    switch (mood) {
      case '😄 Very Happy':
        return '😄';
      case '🙂 Happy':
        return '🙂';
      case '😐 Neutral':
        return '😐';
      case '☹️ Sad':
        return '☹️';
      case '😢 Very Sad':
        return '😢';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entries'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Error loading entries'))
          : _entries.isEmpty
          ? Center(child: Text('No entries found.'))
          : ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          return _buildEntryCard(context, _entries[index]);
        },
      ),
      bottomNavigationBar: FSKNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/mood_entry');
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, // Align FAB to the right inside BottomAppBar
    );
  }
}

class FSKNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(Icons.dashboard, 'Profile', '/user_profile', context, false),
          _buildNavBarItem(Icons.book, 'Journal', '/journal', context, true), // Highlighted
          _buildNavBarItem(Icons.show_chart, 'Statistics', '/statistics', context, false),
          SizedBox(width: 48), // Middle space for FAB
        ],
      ),
    );
  }

  Widget _buildNavBarItem(
      IconData icon, String label, String route, BuildContext context, bool highlighted) {
    return IconButton(
      icon: Icon(icon),
      color: highlighted ? Colors.blue : Colors.grey,
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      tooltip: label,
    );
  }
}
