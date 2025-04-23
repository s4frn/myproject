import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(color: Colors.black),
              ),
            ),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (value) {
                if (value == 'settings') {
                  Navigator.pushNamed(context, '/settings');
                } else if (value == 'help') {
                  Navigator.pushNamed(context, '/helpsupport');
                } else if (value == 'logout') {
                  Navigator.pushReplacementNamed(context, '/logout');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(value: 'settings', child: Text('Settings')),
                  const PopupMenuItem(value: 'helpsupport', child: Text('Help Support')),
                  const PopupMenuItem(value: 'logout', child: Text('Log Out')),
                ];
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Developer Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: AssetImage('assets/picsaf.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _buildInfoField("Name", "Suhana Safrani"),
            const SizedBox(height: 10),
            _buildInfoField("Class", "4B"),
            const SizedBox(height: 10),
            _buildInfoField("ID", "DFI2307042"),
            const SizedBox(height: 10),
            _buildInfoField("Age", "21"),
            const SizedBox(height: 10),
            _buildInfoField("Education", "Diploma in Electronic Engineering (IoT)"),
            const SizedBox(height: 10),
            _buildInfoField("Background Summary", "A passionate student focused on front-end development and IoT systems integration. Skilled in Flutter, Firebase, and UI design."),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEECEC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
