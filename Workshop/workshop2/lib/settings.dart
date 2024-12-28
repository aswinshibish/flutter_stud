import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final void Function(bool) onThemeToggle;  // Accept the callback function

  const SettingsPage({Key? key, required this.onThemeToggle}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Title text color
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
        children: [
          // Theme Section
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(isDarkTheme ? 'Dark' : 'Light'),
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (value) {
                setState(() {
                  isDarkTheme = value;
                });
                widget.onThemeToggle(isDarkTheme);  // Trigger theme change
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
