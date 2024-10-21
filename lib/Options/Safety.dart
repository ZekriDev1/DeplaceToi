import 'package:flutter/material.dart';
import 'package:deplacetoi/screens/app_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafetyScreen(),
    );
  }
}

class SafetyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () => _callEmergency(),
              icon: Icon(Icons.warning_amber_rounded),
              label: Text('Call emergency'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16.0),

            // Section Title
            Text(
              "How you're protected",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // Grid of Protection Features
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  buildProtectionFeature(
                    Icons.info_outline,
                    'Before the ride',
                  ),
                  buildProtectionFeature(
                    Icons.perm_identity,
                    'Driver identity and selfie verification',
                  ),
                  buildProtectionFeature(
                    Icons.verified_user_outlined,
                    'Safety features',
                  ),
                  buildProtectionFeature(
                    Icons.chat,
                    '24/7 emergency chat',
                  ),
                  buildProtectionFeature(
                    Icons.car_rental,
                    'we check cars',
                  ),
                  buildProtectionFeature(
                    Icons.message_outlined,
                    'Safe communications',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for each option card (Support, Emergency contacts)
  Widget buildOptionCard(IconData icon, String label, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40.0, color: Colors.black),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for each protection feature in the grid
  Widget buildProtectionFeature(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50.0, color: Colors.pinkAccent),
          SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle phone call
  void _callEmergency() async {
    final url = 'tel:911';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
      print('Could not launch $url');
    }
  }

  // Function to open the email app
  void _sendEmail() async {
    final emailUrl = 'mailto:ma.zekri@hotmail.com?subject=Support Request';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      // Handle the error
      print('Could not launch $emailUrl');
    }
  }

  // Function to handle URL launch
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
      print('Could not launch $url');
    }
  }
}
