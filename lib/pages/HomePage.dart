// ignore_for_file: file_names

import 'package:advent_of_code_23/pages/DayOnePage.dart';
import 'package:advent_of_code_23/pages/DayThreePage.dart';
import 'package:advent_of_code_23/pages/DayTwoPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayOnePage()),
                );
              },
              child: const Text('Day One'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayTwoPage()),
                );
              },
              child: const Text('Day Two'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayThreePage()),
                );
              },
              child: const Text('Day Three'),
            ),
            // Add more buttons for other pages
          ],
        ),
      ),
    );
  }
}