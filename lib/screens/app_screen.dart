import 'dart:convert';
import 'dart:io';
import 'package:deplacetoi/Options/FAQ.dart';
import 'package:deplacetoi/screens/DriverMode.dart';
import 'package:deplacetoi/Options/RequestHistory.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deplacetoi/Options/Safety.dart';
import 'package:deplacetoi/Options/Settings.dart';
import 'package:deplacetoi/Options/BestDriver.dart';
import 'package:url_launcher/url_launcher.dart';

const String kGoogleApiKey = 'AIzaSyAOVYRIgupAurZup5y1PRh8Ismb1A3lLao';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  String userName = 'Loading...';
  String homeAddress = 'Loading...';
  String profileImagePath = '';
  TextEditingController _placeController = TextEditingController();
  List<dynamic> _placePredictions = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _navigateToPlace() async {
    final placeName = _placeController.text;
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$placeName';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'User';
      homeAddress = prefs.getString('home_address') ?? 'Your Home Address';
      profileImagePath = prefs.getString('profile_image_path') ?? '';
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) return;

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$kGoogleApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _placePredictions = data['predictions'];
      });
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.navigation),
            onPressed: _navigateToPlace,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userName,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              accountEmail:
                  Text(homeAddress, style: TextStyle(color: Colors.black87)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: profileImagePath.isNotEmpty
                    ? FileImage(File(profileImagePath))
                    : null,
                child: profileImagePath.isEmpty
                    ? Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.grey[700]),
              title: Text('Request history'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestHistory()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delivery_dining, color: Colors.grey[700]),
              title: Text('Couriers'),
              onTap: () {
                // Handle Couriers tap
              },
            ),
            ListTile(
              leading: Icon(Icons.public, color: Colors.grey[700]),
              title: Text('Best Driver Of The Day !'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestDriverTab()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shield, color: Colors.grey[700]),
              title: Text('Safety'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SafetyScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[700]),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.grey[700]),
              title: Text('FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent, color: Colors.grey[700]),
              title: Text('Support'),
              onTap: () {
                // Handle Support tap
              },
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverMode()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text('Driver Mode', style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.mail, color: Colors.pink),
                    onPressed: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'ma.zekri@hotmail.com',
                      );
                      if (await canLaunch(emailUri.toString())) {
                        await launch(emailUri.toString());
                      } else {
                        throw 'Could not launch email client';
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(31.7917, -7.0926), // Coordinates for Morocco
              zoom: 6.0,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter place name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    controller: _placeController,
                    onChanged: _searchPlaces,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'To',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      hintText: 'MAD Offer your fare',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child:
                        Text('Find a Driver', style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.car_rental),
                          Text('Ride'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.motorcycle),
                          Text('Moto'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.local_taxi),
                          Text('Taxi'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.directions_bus),
                          Text('City to city'),
                        ],
                      ),
                    ],
                  ),
                  if (_placePredictions.isNotEmpty) // Display suggestions
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _placePredictions.length,
                        itemBuilder: (context, index) {
                          final prediction = _placePredictions[index];
                          return ListTile(
                            title: Text(prediction['description'] ?? ''),
                            onTap: () {
                              // Handle place selection
                            },
                          );
                        },
                      ),
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
