import 'package:flutter/material.dart';

class ViewHistoryPage extends StatelessWidget {
  // Sample data for accidents
  final List<Map<String, dynamic>> accidents = [
    {
      'altitude': 100,
      'latitude': 22.2530,
      'longitude': 84.9016,
      'time': '2023-01-01 12:00 PM',
      'speed': 50,
    },
    {
      'altitude': 150,
      'latitude': 22.2550,
      'longitude': 84.9020,
      'time': '2023-01-02 01:30 PM',
      'speed': 60,
    },
    {
      'altitude': 120,
      'latitude': 22.2510,
      'longitude': 84.9000,
      'time': '2023-01-03 03:45 PM',
      'speed': 40,
    },
    // Add more accident data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Records'),
        backgroundColor: Color(0XFF005653), // Set the app bar color
      ),
      body: ListView.builder(
        itemCount: accidents.length,
        itemBuilder: (context, index) {
          return AccidentCard(index: index + 1, accidentData: accidents[index]);
        },
      ),
    );
  }
}

class AccidentCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> accidentData;

  const AccidentCard({Key? key, required this.index, required this.accidentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Accident $index', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16), // Increase the space here
            Text('Altitude: ${accidentData['altitude']}'),
            SizedBox(height: 8),
            Text('Latitude: ${accidentData['latitude']}'),
            SizedBox(height: 8),
            Text('Longitude: ${accidentData['longitude']}'),
            SizedBox(height: 8),
            Text('Time: ${accidentData['time']}'),
            SizedBox(height: 8),
            Text('Speed: ${accidentData['speed']}'),
          ],
        ),
      ),
    );
  }
}
