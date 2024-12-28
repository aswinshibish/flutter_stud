import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        flexibleSpace: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "image/appbar4.jpg"), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.blue[900]!
                  .withOpacity(0.7), // Background color with transparency
            ),
          ],
        ),
        title: const Text(
          'INFORMATION',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3C72), // Customize app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Color Format Section
            const Text(
              'Color Format',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: const Color(0xFFD9E6FF), // Light blue background for list
              child: Column(
                children: [
                  _colorFormatTile('Attendance', Colors.purple[100]!),
                  _colorFormatTile('Event Participation', Colors.blue[100]!),
                  _colorFormatTile('Academic Marks', Colors.blue[800]!),
                  _colorFormatTile('POP Participation', Colors.indigo[900]!),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Percentage Format Section
            const Text(
              'Percentage Format',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: const Color(0xFFD9E6FF), // Light blue background for list
              child: Column(
                children: [
                  _percentageFormatTile('Attendance', '20%'),
                  _percentageFormatTile('Event Participation', '10%'),
                  _percentageFormatTile('Academic Marks', '40%'),
                  _percentageFormatTile('POP Participation', '30%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create a color box list item
  Widget _colorFormatTile(String label, Color color) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Text(label, style: const TextStyle(fontSize: 18)),
      trailing: Container(
        width: 24,
        height: 24,
        color: color,
      ),
    );
  }

  // Helper function to create a percentage list item
  Widget _percentageFormatTile(String label, String percentage) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Text(label, style: const TextStyle(fontSize: 18)),
      trailing: Text(
        percentage,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: InformationScreen(),
  ));
}
