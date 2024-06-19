import 'package:flutter/material.dart';

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
