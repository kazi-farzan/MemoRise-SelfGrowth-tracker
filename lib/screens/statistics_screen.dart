import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> last15Days = List<String>.generate(15, (i) => (15 - i).toString());
  final List<String> moodEmojis = ['😢', '☹️', '😐', '🙂', '😄']; // Reversed order
  final List<String> moodLabels = ['Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy']; // Reversed order

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics & Insights'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Weekly Mood Trends',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 200.0,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return weekDays[value.toInt()];
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return moodEmojis[value.toInt()];
                      },
                      reservedSize: 28,
                      margin: 12,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 4,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0), // Monday - Very Sad
                        FlSpot(1, 1), // Tuesday - Sad
                        FlSpot(2, 2), // Wednesday - Neutral
                        FlSpot(3, 3), // Thursday - Happy
                        FlSpot(4, 4), // Friday - Very Happy
                        FlSpot(5, 3), // Saturday - Happy
                        FlSpot(6, 2), // Sunday - Neutral
                      ],
                      isCurved: false, // Use sharp points instead of curves
                      colors: [Colors.blue],
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Monthly Mood Trends',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 200.0,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return last15Days[value.toInt()];
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return moodEmojis[value.toInt()];
                      },
                      reservedSize: 28,
                      margin: 12,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: 0,
                  maxX: 14,
                  minY: 0,
                  maxY: 4,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        // Last 7 days same as weekly graph
                        FlSpot(0, 2),  // 15 days ago - Neutral
                        FlSpot(1, 1),  // 14 days ago - Happy
                        FlSpot(2, 3),  // 13 days ago - Sad
                        FlSpot(3, 0),  // 12 days ago - Very Happy
                        FlSpot(4, 4),  // 11 days ago - Very Sad
                        FlSpot(5, 3),  // 10 days ago - Happy
                        FlSpot(6, 1),  // 9 days ago - Happy
                        FlSpot(7, 3),  // 8 days ago - Sad
                        FlSpot(8, 4),  // 7 days ago - Very Sad
                        FlSpot(9, 3),  // 6 days ago - Happy
                        FlSpot(10, 2), // 5 days ago - Neutral
                        FlSpot(11, 1), // 4 days ago - Happy
                        FlSpot(12, 0), // 3 days ago - Very Happy
                        FlSpot(13, 2), // 2 days ago - Neutral
                        FlSpot(14, 1), // 1 day ago - Happy
                      ],
                      isCurved: false, // Use sharp points instead of curves
                      colors: [Colors.orange],
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Add Entry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistics',
          ),
        ],
        currentIndex: 4, // Current index of Statistics screen
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
              Navigator.pushNamed(context, '/journal');
              break;
            case 4:
            // Stay on Statistics screen
              break;
          }
        },
      ),
    );
  }
}
