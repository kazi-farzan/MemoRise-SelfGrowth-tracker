import 'package:flutter/material.dart';

class ProfilePictureOptionsDialog extends StatelessWidget {
  final Function(String) onSelect;

  ProfilePictureOptionsDialog({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Profile Picture'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              onSelect('assets/user_icon.png');
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user_icon.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              onSelect('assets/user_icon_female.png'); // Replace with your female version image
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user_icon_female.png'), // Replace with your female version image
            ),
          ),
        ],
      ),
    );
  }
}
