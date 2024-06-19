import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgeCard extends StatelessWidget {
  final String name;
  final String asset;
  final bool achieved;
  final int stars;
  final String description;

  BadgeCard({
    required this.name,
    required this.asset,
    required this.achieved,
    required this.stars,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBadgeDialog(context, name, asset, stars, description);
      },
      child: Container(
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
      ),
    );
  }

  void _showBadgeDialog(BuildContext context, String name, String asset, int stars, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              SvgPicture.asset(
                asset,
                height: 60,
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
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(description),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
