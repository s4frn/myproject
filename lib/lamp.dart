import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class LampPage extends StatefulWidget {
  const LampPage({super.key});

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {

  final DatabaseReference myRTDB = FirebaseDatabase.instance.ref();
  bool pumpSwitch = false;
  
  void loadSwitchStatus(){
    myRTDB.child('Actuator/led').onValue.listen((event){
      setState(() {
        pumpSwitch = event.snapshot.value as bool? ?? false;
      });
    });
  }
  
  void updatePumpSwitch(bool value){
    myRTDB.child('Actuator/led').set(value);
    setState(() {
      pumpSwitch = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSwitchStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lamp'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFE48E),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text('Actuator Control'),
            Card(
              color: Color(0xFFFFFFFF),
              child: ListTile(
                title: Text('Lamp 1'),
                trailing: Switch(
                    value: pumpSwitch,
                    onChanged: (bool value){updatePumpSwitch(value);}
                ),
              ),
            )
          ],
        ),),
      ),
    );
  }
}
