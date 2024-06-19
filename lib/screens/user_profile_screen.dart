import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/badge_card.dart';
import '../widgets/fsk_navbar.dart';
import '../dialogs/edit_name_dialog.dart';
import '../dialogs/profile_picture_options_dialog.dart';
import '../data/badges_data.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String userName = 'Farzan Kazi';
  String profileImage = 'assets/user_icon.png';

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
                      backgroundImage: AssetImage(profileImage),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showProfilePictureOptions();
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
                      userName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditNameDialog();
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
                    achieved: badge['stars'] > 0,
                    description: badge['description'],
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

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditNameDialog(
          initialName: userName,
          onSave: (newName) {
            setState(() {
              userName = newName;
            });
          },
        );
      },
    );
  }

  void _showProfilePictureOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePictureOptionsDialog(
          onSelect: (newImage) {
            setState(() {
              profileImage = newImage;
            });
          },
        );
      },
    );
  }
}
