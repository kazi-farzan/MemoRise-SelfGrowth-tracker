import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:memorise/providers/entry_data_provider.dart'; // Adjust import path based on your project structure
import 'package:memorise/screens/dashboard_screen.dart'; // Import screens
import 'package:memorise/screens/mood_entry_screen.dart';
import 'package:memorise/screens/settings_screen.dart';
import 'package:memorise/screens/calendar_view_screen.dart';
import 'package:memorise/screens/journal_screen.dart';
import 'package:memorise/screens/statistics_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryDataProvider(), // Initialize your data provider
      child: MaterialApp(
        title: 'memoRise',
    theme: ThemeData(
    primarySwatch: Colors.blue,
    // Define the bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue, // Color of the selected item
    unselectedItemColor: Colors.black, // Color of the unselected items (icons)
    ),),
        initialRoute: '/dashboard', // Define initial route
        routes: {
          '/dashboard': (context) => DashboardScreen(),
          '/mood_entry': (context) => MoodEntryScreen(),
          '/settings': (context) => SettingsScreen(),
          '/calendar_view': (context) => CalendarViewScreen(),
          '/journal': (context) => JournalScreen(),
          '/statistics': (context) => StatisticsScreen(),
        },
      ),
    );
  }
}
