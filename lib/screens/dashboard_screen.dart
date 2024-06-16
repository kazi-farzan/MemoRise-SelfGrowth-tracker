import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memorise/providers/entry_data_provider.dart'; // Adjust path as per your project structure
import 'package:memorise/models/journal_entry.dart'; // Adjust path as per your project structure

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the EntryDataProvider instance
    EntryDataProvider entryProvider = Provider.of<EntryDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('memoRise'),
        // Add any app bar actions if needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recent Moods Overview
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Recent Moods',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Display recent moods using a ListView or GridView
            Expanded(
              child: ListView.builder(
                itemCount: entryProvider.entries.length,
                itemBuilder: (context, index) {
                  JournalEntry entry = entryProvider.entries[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getMoodColor(entry.mood), // Use mood color
                      child: Text(entry.moodEmoji), // Use mood icon
                    ),
                    title: Text('Date: ${_formatDate(entry.date)}'),
                    subtitle: Text('Notes: ${entry.notes}'),
                    // Add onTap to view more details if needed
                  );
                },
              ),
            ),
          ],
        ),
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
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistics',
          ),
        ],
        currentIndex: 0, // Current index of Dashboard screen
        selectedItemColor: Colors.blue, // Adjust color as needed
        onTap: (int index) {
          switch (index) {
            case 0:
            // Stay on Dashboard screen
              break;
            case 1:
              Navigator.pushNamed(context, '/calendar_view');
              break;
            case 2:
              Navigator.pushNamed(context, '/mood_entry');
              break;
            case 3:
              Navigator.pushNamed(context, '/journal');
              break;
            case 4:
              Navigator.pushNamed(context, '/statistics');
              break;
          }
        },
      ),
    );
  }

  // Method to get mood color based on mood type
  Color _getMoodColor(String mood) {
    // Implement your logic to return appropriate colors based on mood
    // Example implementation:
    switch (mood) {
      case 'happy':
        return Colors.blue; // Example color for positive mood
      case 'sad':
        return Colors.red; // Example color for negative mood
      default:
        return Colors.grey; // Default color for unknown mood
    }
  }

  // Method to format date
  String _formatDate(DateTime date) {
    // Implement your date formatting logic here
    // Example implementation:
    return '${date.year}-${date.month}-${date.day}';
  }
}
