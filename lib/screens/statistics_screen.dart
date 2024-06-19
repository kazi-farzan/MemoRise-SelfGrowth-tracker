import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> last15Days = List<String>.generate(15, (i) => (i + 1).toString());
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
            _buildSectionTitle('Weekly Mood Trends'),
            _buildLineChart(weekDays, [2, 3, 1, 4, 3, 2, 1], Colors.blue, xLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],), // New example data
            _buildInsights([0, 1, 2, 2, 1]), // Example data, adjust as per your logic

            SizedBox(height: 20.0),

            _buildSectionTitle('Monthly Mood Trends'),
            _buildLineChart(
              last15Days,
              [2, 3, 1, 4, 3, 2, 1, 3, 4, 3, 2, 1, 4, 3, 2],
              Colors.green,
              flipXAxis: true,
              xLabels: ['1', '3', '6', '9', '12', '15'],
            ), // Example data, adjust as per your logic
            _buildInsights([0, 3, 5, 4, 3]), // Example data, adjust as per your logic
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/mood_entry');
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: FSKNavbar(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLineChart(
      List<String> bottomTitles,
      List<double> data,
      Color color, {
        bool flipXAxis = false,
        List<String> xLabels = const [], // Provide a default empty list
      }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 300.0,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  int index = flipXAxis
                      ? (bottomTitles.length - 1 - value.toInt())
                      : value.toInt();
                  if (index < 0 || index >= bottomTitles.length) return '';
                  String label = bottomTitles[index];
                  return xLabels.contains(label) ? label : '';
                },
                interval: 1,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  if (value.toInt() >= 0 && value.toInt() < moodEmojis.length) {
                    return moodEmojis[value.toInt()];
                  }
                  return '';
                },
                interval: 1,
                reservedSize: 28,
                margin: 12,
              ),
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false, // Remove the border outline
            ),
            minX: 0,
            maxX: bottomTitles.length.toDouble() - 1,
            minY: 0,
            maxY: 4,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(data.length, (index) => FlSpot(index.toDouble(), data[index])),
                isCurved: true, // Use curves instead of sharp points
                colors: [color],
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true, // Show area below the line
                  colors: [color.withOpacity(0.3)], // Use semi-transparent color for the area
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsights(List<int> moodCounts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Insights',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: List.generate(moodCounts.length, (index) {
            String emoji = moodEmojis[index];
            String label = moodLabels[index];
            int count = moodCounts[index];
            String dayText = count == 1 ? 'day' : 'days';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Text(
                    emoji,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '$count $dayText',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 16),
      ],
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
          _buildNavBarItem(Icons.dashboard, 'Profile', '/user_profile', context, false), // Highlighted
          _buildNavBarItem(Icons.book, 'Journal', '/journal', context, false),
          _buildNavBarItem(Icons.show_chart, 'Statistics', '/statistics', context, true),
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

void main() {
  runApp(MaterialApp(
    title: 'Statistics App',
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/statistics',
    routes: {
      '/statistics': (context) => StatisticsScreen(),
      // Add other routes as needed
    },
  ));
}
