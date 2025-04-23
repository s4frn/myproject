import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RssiPage extends StatefulWidget {
  const RssiPage({super.key});

  @override
  State<RssiPage> createState() => _RssiPageState();
}

class _RssiPageState extends State<RssiPage> {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://project-f43c4-default-rtdb.asia-southeast1.firebasedatabase.app/",).ref();
  String rssiValue = '0';

  void _readSensorValue(){

    myRTDB.child('Sensor/rssi').onValue.listen(
            (event){
          final Object? rssiData = event.snapshot.value;
          setState(() {
            rssiValue = rssiData.toString();
          });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    _readSensorValue();
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
                Expanded(child: _buildInfoCard('Today', currentDate)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard('RSSI', "$rssiValue dBm")),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Current RSSI",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: -100,
                      maximum: 0,
                      ranges: <GaugeRange>[
                        GaugeRange(startValue: -100, endValue: -70, color: Colors.red),
                        GaugeRange(startValue: -70, endValue: -50, color: Colors.orange),
                        GaugeRange(startValue: -50, endValue: 0, color: Colors.green),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: double.tryParse(rssiValue) ?? -100),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            "$rssiValue dBm",
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          angle: 90,
                          positionFactor: 0.6,
                        ),
                      ],
                    ),
                  ],
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
