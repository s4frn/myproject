import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Iot_Monitoring.dart';
import 'package:myproject/firebase_options.dart';
import 'package:myproject/first.dart';
import 'package:myproject/home.dart';
import 'package:myproject/humidity.dart';
import 'package:myproject/lamp.dart';
import 'package:myproject/logout.dart';
import 'package:myproject/rssi.dart';
import 'package:myproject/settings.dart';
import 'package:myproject/signin_screen.dart';
import 'package:myproject/soil.dart';
import 'package:myproject/temperature.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstPage(),
        routes: {
          '/home': (context) => Homepage(),
          '/temperature': (context) => TemperaturePage(),
          '/lamp': (context) => LampPage(),
          '/humidity': (context) => HumidityPage(),
          '/rssi': (context) => RssiPage(),
          '/soil_moisture': (context) => SoilPage(),
          '/settings': (context) => SettingsPage(),
          '/logout': (context) => LogoutPage(),
          '/first': (context) => FirstPage(),
        }
      // Corrected instantiation of FirstPage
    );
  }
}
