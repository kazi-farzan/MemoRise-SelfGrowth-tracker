import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileScreen extends StatelessWidget {
  final List<Map<String, dynamic>> badges = [
    {'name': 'First Entry', 'asset': 'assets/badges/first_entry.svg', 'stars': 1},
    {'name': 'Weekly Streak', 'asset': 'assets/badges/weekly_streak.svg', 'stars': 2},
    {'name': 'Monthly Streak', 'asset': 'assets/badges/monthly_streak.svg', 'stars': 1},
    {'name': 'Exercise Enthusiast', 'asset': 'assets/badges/exercise_enthusiast.svg', 'stars': 1},
    {'name': 'Consistency King', 'asset': 'assets/badges/consistency_king.svg', 'stars': 2},
    {'name': 'Meditation Master', 'asset': 'assets/badges/meditation_master.svg', 'stars': 0}, // Updated stars to 0
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/user_icon.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Add functionality to change profile picture
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Farzan Kazi',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Add functionality to edit username
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  'Level 1',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.7, // Dummy XP value
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Text(
                'Streak',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Current Streak',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '5 days', // Dummy value
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Longest Streak',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '10 days', // Dummy value
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Badges',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: badges.map((badge) {
                  return BadgeCard(
                    name: badge['name'],
                    asset: badge['asset'],
                    stars: badge['stars'],
                    achieved: badge['stars'] > 0, // Achieved if stars are greater than 0
                  );
                }).toList(),
              ),
            ],
          ),
        ),
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
          _buildNavBarItem(Icons.dashboard, 'Profile', '/profile', context, true), // Highlighted
          _buildNavBarItem(Icons.book, 'Journal', '/journal', context, false),
          _buildNavBarItem(Icons.show_chart, 'Statistics', '/statistics', context, false),
          SizedBox(width: 48), // Middle space for FAB
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, String route, BuildContext context, bool highlighted) {
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

class BadgeCard extends StatelessWidget {
  final String name;
  final String asset;
  final bool achieved;
  final int stars;

  BadgeCard({required this.name, required this.asset, required this.achieved, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: achieved ? Colors.white : Colors.grey[300],
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            asset,
            height: 60,
            color: achieved ? null : Colors.grey, // Color badges gray if not achieved
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: index < stars ? Colors.amber : Colors.grey,
                size: 20,
              );
            }),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center, // Center align text
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: achieved ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
