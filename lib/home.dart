import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/first.dart';
import 'package:myproject/logout.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String userName = user?.displayName ?? "User";
    String currentDate = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FirstPage()),
            );
          },
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogoutPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(value: 'settings', child: Text('Settings')),
                  const PopupMenuItem(value: 'help', child: Text('Help Support')),
                  const PopupMenuItem(value: 'logout', child: Text('Log Out')),
                ];
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Welcome, $userName!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildInfoCard('Today', currentDate)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard('Temperature', "24°C")),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Monitor your systems",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildSensorTile(context, Icons.water_drop, 'humidity', '/humidity'),
                  _buildSensorTile(context, Icons.thermostat, 'temperature', '/temperature'),
                  _buildSensorTile(context, Icons.lightbulb, 'lamp', '/lamp'),
                  _buildSensorTile(context, Icons.water, 'pump', '/pump'),
                  _buildSensorTile(context, Icons.signal_cellular_alt, 'rssi', '/rssi'),
                  _buildSensorTile(context, Icons.grass, 'soil moisture', '/soil_moisture'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(value, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSensorTile(BuildContext context, IconData icon, String label, String route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
