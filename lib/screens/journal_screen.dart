import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memorise/providers/entry_data_provider.dart'; // Adjust path as per your project structure
import 'package:memorise/models/journal_entry.dart'; // Adjust path as per your project structure

class JournalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the EntryDataProvider instance
    EntryDataProvider entryProvider = Provider.of<EntryDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Journal/Notes'),
      ),
      body: ListView.builder(
        itemCount: entryProvider.entries.length,
        itemBuilder: (context, index) {
          JournalEntry entry = entryProvider.entries[index];
          return _buildEntryCard(context, entry);
        },
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
        currentIndex: 3, // Current index of Journal screen
        selectedItemColor: Colors.blue, // Adjust color as needed
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushNamed(context, '/calendar_view');
              break;
            case 2:
              Navigator.pushNamed(context, '/mood_entry');
              break;
            case 3:
            // Stay on Journal screen
              break;
            case 4:
              Navigator.pushNamed(context, '/statistics');
              break;
          }
        },
      ),
    );
  }

  Widget _buildEntryCard(BuildContext context, JournalEntry entry) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          '${_formatDate(entry.date)} - ${_formatMood(entry.mood)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text('Note: ${entry.notes}'),
            SizedBox(height: 8.0),
            Text('Activities: ${entry.activities.join(', ')}'),
          ],
        ),
        onTap: () {
          // Navigate to detailed entry view or implement editing functionality
          _navigateToEntryDetail(context, entry);
        },
      ),
    );
  }

  void _navigateToEntryDetail(BuildContext context, JournalEntry entry) {
    // Navigate to detailed entry view screen or implement editing
    // Example: Navigator.pushNamed(context, '/journal_entry_detail', arguments: entry);
    // You would need to implement JournalEntryDetailScreen separately
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatMood(String mood) {
    // Add custom formatting if needed
    return mood;
  }
}
