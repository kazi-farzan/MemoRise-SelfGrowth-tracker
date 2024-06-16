import 'package:flutter/material.dart';
import 'package:memorise/models/journal_entry.dart'; // Adjust the import path based on your project structure

class EntryDataProvider extends ChangeNotifier {
  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  void addEntry(JournalEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteEntry(JournalEntry entry) {
    _entries.remove(entry);
    notifyListeners();
  }

  void updateEntry(JournalEntry updatedEntry) {
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].date == updatedEntry.date) {
        _entries[i] = updatedEntry;
        notifyListeners();
        return;
      }
    }
    // Handle case where entry with matching date is not found
    // Alternatively, throw an error or log a message
  }

// Additional methods for data persistence (e.g., saving/loading from storage) can be added here
}
