import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {

  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://project-f43c4-default-rtdb.asia-southeast1.firebasedatabase.app/",).ref();
  String soil_moistureValue = '0';

  void _readSensorValue(){

    // read RSSI value from firebase RTDB
    myRTDB.child('Sensor/soil_moisture').onValue.listen(
            (event){
          final Object? soil_moistureData = event.snapshot.value;
          setState(() {
            soil_moistureValue = soil_moistureData.toString();
          });
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readSensorValue();
  }// Example temperature value


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage
          },
        ),
        title: const Text("Soil Moisture", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.pushNamed(context, '/settings');
              } else if (value == 'help') {
                Navigator.pushNamed(context, '/help');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center everything
        children: [
          // Current Temperature Text (Higher & Larger)
          const Text("Current Soil Moisture",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("$soil_moistureValue °C",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),

          const SizedBox(height: 30),

          // Centered Gauge
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 50,
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 0, endValue: 20, color: Colors.blue),
                      GaugeRange(startValue: 20, endValue: 35, color: Colors.green),
                      GaugeRange(startValue: 35, endValue: 50, color: Colors.red),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: double.tryParse(soil_moistureValue) ?? 0),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text("$soil_moistureValue °C",
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

