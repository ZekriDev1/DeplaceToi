import 'package:flutter/material.dart';

class BestDriverTab extends StatelessWidget {
  final List<Map<String, dynamic>> drivers = [
    {
      'name': 'Akram Zekri',
      'rides': '27 Rides',
      'image': 'assets/AkramZekri.jpg',
      'rating': 5
    },
    {
      'name': 'Morad khlifi',
      'rides': '25 Rides',
      'image': 'assets/images/driver2.png',
      'rating': 4.5
    },
    {
      'name': 'Ahmed merini',
      'rides': '22 Rides',
      'image': 'assets/images/driver3.png',
      'rating': 4.5
    },
    {
      'name': 'soulaymen Hamadani',
      'rides': '19 Rides',
      'image': 'assets/images/driver4.png',
      'rating': 4.5
    },
    {
      'name': 'abdelah kaydi',
      'rides': '17 Rides',
      'image': 'assets/images/driver5.png',
      'rating': 4
    },
    {
      'name': 'ousama ben laden',
      'rides': '15 Rides',
      'image': 'assets/ousama.png',
      'rating': 3.5
    },
    {
      'name': 'saddam hussein',
      'rides': '12 Rides',
      'image': 'assets/sadam.webp',
      'rating': 3.2
    },
    {
      'name': 'Driss DotCom hh Li bgha ys9et Mar7ba',
      'rides': '10 Rides',
      'image': 'assets/Driss.png',
      'rating': 3
    },
    {
      'name': 'nigga Driver',
      'rides': '9 Rides',
      'image': 'assets/nigga.png',
      'rating': 3
    },
    {
      'name': 'SIGMA Driver LOL',
      'rides': '7 Rides',
      'image': 'assets/sigma.png',
      'rating': 2.7
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Drivers"),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          final driver = drivers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(driver['image']),
              radius: 30,
            ),
            title: Text(driver['name']),
            subtitle: Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  starIndex < driver['rating'] ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 20,
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
