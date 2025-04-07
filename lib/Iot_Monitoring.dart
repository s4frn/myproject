import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class IotMonitoringPage extends StatefulWidget {
  const IotMonitoringPage({super.key});

  @override
  State<IotMonitoringPage> createState() => _IotMonitoringPageState();
}

class _IotMonitoringPageState extends State<IotMonitoringPage> {

  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://project-f43c4-default-rtdb.asia-southeast1.firebasedatabase.app/",).ref();
  String rssiValue = '0';

  void _readSensorValue(){

    // read RSSI value from firebase RTDB
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
    // TODO: implement initState
    super.initState();
    _readSensorValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor'),
        centerTitle: true,
        backgroundColor: Color(0xFF7A0823),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Card(
              child: Column(
                children: [
                  Text('RSSI Value', style: TextStyle(fontSize: 35),),
                  Text('$rssiValue dBm', style: TextStyle(fontSize: 25),)
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}