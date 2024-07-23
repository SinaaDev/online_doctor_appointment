import 'dart:ui';

import 'package:flutter/material.dart';

class BodySystemWidget extends StatelessWidget {
  final BodySystem bodySystem;

  BodySystemWidget({required this.bodySystem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 6),
      child: Card(
        elevation: 0.5,
        child: ListTile(
          leading: Icon(
            bodySystem.icon,
            color: bodySystem.color,
            size: 40.0,
          ),
          title: Text(bodySystem.name),
          subtitle: LinearProgressIndicator(
            value: bodySystem.status / 100,
            color: bodySystem.color,
            backgroundColor: bodySystem.color.withOpacity(0.2),
          ),
          trailing: Text(
            '${bodySystem.status}%',
            style: TextStyle(
              color: bodySystem.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BodySystem {
  final String name;
  final double status; // Percentage of working status
  final IconData icon;
  final Color color;

  BodySystem({
    required this.name,
    required this.status,
    required this.icon,
    required this.color,
  });
}

class BodyStatusScreen extends StatelessWidget {
  final List<BodySystem> bodySystems = [
    BodySystem(
      name: 'Cardiovascular',
      status: 90.0,
      icon: Icons.favorite,
      color: Colors.red,
    ),
    BodySystem(
      name: 'Respiratory',
      status: 80.0,
      icon: Icons.air,
      color: Colors.blue,
    ),
    BodySystem(
      name: 'Digestive',
      status: 70.0,
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    BodySystem(
      name: 'Nervous',
      status: 95.0,
      icon: Icons.airline_seat_flat_angled_rounded,
      color: Colors.purple,
    ),
    BodySystem(
      name: 'Muscular',
      status: 85.0,
      icon: Icons.fitness_center,
      color: Colors.green,
    ),
    BodySystem(
      name: 'Skeletal',
      status: 75.0,
      icon: Icons.accessibility_new,
      color: Colors.brown,
    ),
    BodySystem(
      name: 'Endocrine',
      status: 88.0,
      icon: Icons.medication,
      color: Colors.pink,
    ),
    BodySystem(
      name: 'Lymphatic',
      status: 65.0,
      icon: Icons.health_and_safety,
      color: Colors.teal,
    ),
    BodySystem(
      name: 'Urinary',
      status: 82.0,
      icon: Icons.water_damage,
      color: Colors.indigo,
    ),
    BodySystem(
      name: 'Reproductive',
      status: 78.0,
      icon: Icons.pregnant_woman,
      color: Colors.deepOrange,
    ),
    BodySystem(
      name: 'Immune',
      status: 90.0,
      icon: Icons.shield,
      color: Colors.lightGreen,
    ),
    BodySystem(
      name: 'Integumentary',
      status: 80.0,
      icon: Icons.texture,
      color: Colors.amber,
    ),
    BodySystem(
      name: 'Sensory',
      status: 92.0,
      icon: Icons.visibility,
      color: Colors.cyan,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: bodySystems.length,
            itemBuilder: (context, index) {
              return BodySystemWidget(bodySystem: bodySystems[index]);
            },
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: const Text(
                    'Coming\nSoon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
