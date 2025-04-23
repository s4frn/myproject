import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PumpPage extends StatefulWidget {
  const PumpPage({super.key});

  @override
  State<PumpPage> createState() => _PumpPageState();
}

class _PumpPageState extends State<PumpPage> {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://project-f43c4-default-rtdb.asia-southeast1.firebasedatabase.app/",
  ).ref();

  bool pumpSwitch = false;

  void loadPumpStatus() {
    myRTDB.child('Actuator/pump').onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        pumpSwitch = data == true;
      });
    });
  }

  void updatePumpSwitch(bool value) {
    myRTDB.child('Actuator/pump').set(value);
  }

  @override
  void initState() {
    super.initState();
    loadPumpStatus();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.pushNamed(context, '/settings');
              } else if (value == 'help') {
                Navigator.pushNamed(context, '/helpsupport');
              } else if (value == 'logout') {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildInfoCard("Today", currentDate)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard("Let's control", "your pump!")),
              ],
            ),

            const SizedBox(height: 40),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 600,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.water, size: 120, color: Colors.blue),
                      const Text("Pump", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      Switch(
                        value: pumpSwitch,
                        onChanged: (bool value) => updatePumpSwitch(value),
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
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
}
