import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  List<bool> _isExpandedList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                const PopupMenuItem(value: 'help', child: Text('Help Support')),
                const PopupMenuItem(value: 'logout', child: Text('Log Out')),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Help and Support",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavBox(context, "Contact Us", Icons.phone, () {
                  Navigator.pushNamed(context, '/contact');
                }),
                const SizedBox(width: 16),
                _buildNavBox(context, "Video Tutorials", Icons.play_circle_fill, () {
                  Navigator.pushNamed(context, '/tutorials');
                }),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildFAQ(
                    0,
                    "What is the difference between help and support?",
                    "Help is usually short-term and task-focused, while support is long-term, ongoing, and not always tied to a specific goal or deadline.",
                  ),
                  _buildFAQ(
                    1,
                    "Where is the sensor data sent after it's captured by the Arduino?",
                    "It is sent to Firebase Realtime Database for storage and monitoring.",
                  ),
                  _buildFAQ(
                    2,
                    "Which database does the developer use in Firebase?",
                    "The developer uses Firebase Realtime Database.",
                  ),
                  _buildFAQ(
                    3,
                    "How can I contact the developer about this mobile app?",
                    "Tap the “Contact Us” box to open a form where you can reach the developer.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBox(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.blueGrey),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQ(int index, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(
          _isExpandedList[index] ? Icons.expand_less : Icons.expand_more,
          color: Colors.black,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer, style: const TextStyle(color: Colors.black87)),
          )
        ],
        onExpansionChanged: (expanded) {
          setState(() => _isExpandedList[index] = expanded);
        },
      ),
    );
  }
}
