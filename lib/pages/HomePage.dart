// ignore_for_file: file_names

import 'package:advent_of_code_23/pages/DayOnePage.dart';
import 'package:advent_of_code_23/pages/DayTwoPage.dart';
import 'package:advent_of_code_23/pages/DayThreePage.dart';
import 'package:advent_of_code_23/pages/DayFourPage.dart';
import 'package:advent_of_code_23/pages/DayFivePage.dart';
import 'package:advent_of_code_23/pages/DaySixPage.dart';
import 'package:advent_of_code_23/pages/DaySevenPage.dart';
import 'package:advent_of_code_23/pages/DayEightPage.dart';
import 'package:advent_of_code_23/pages/DayNinePage.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayFourPage()),
                );
              },
              child: const Text('Day Four'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayFivePage()),
                );
              },
              child: const Text('Day Five'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaySixPage()),
                );
              },
              child: const Text('Day Six'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaySevenPage()),
                );
              },
              child: const Text('Day Seven'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayEightPage()),
                );
              },
              child: const Text('Day Eight'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayNinePage()),
                );
              },
              child: const Text('Day Nine'),
            ),
            // Add more buttons for other pages
          ],
        ),
      ),
    );
  }
}