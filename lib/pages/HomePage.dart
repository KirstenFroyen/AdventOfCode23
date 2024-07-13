// ignore_for_file: file_names

import 'package:advent_of_code_23/pages/1/DayOnePage.dart';
import 'package:advent_of_code_23/pages/2/DayTwoPage.dart';
import 'package:advent_of_code_23/pages/3/DayThreePage.dart';
import 'package:advent_of_code_23/pages/4/DayFourPage.dart';
import 'package:advent_of_code_23/pages/5/DayFivePage.dart';
import 'package:advent_of_code_23/pages/6/DaySixPage.dart';
import 'package:advent_of_code_23/pages/7/DaySevenPage.dart';
import 'package:advent_of_code_23/pages/8/DayEightPage.dart';
import 'package:advent_of_code_23/pages/9/DayNinePage.dart';
import 'package:advent_of_code_23/pages/10/DayTenPage.dart';

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
              child: const Text('Day 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayTwoPage()),
                );
              },
              child: const Text('Day 2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayThreePage()),
                );
              },
              child: const Text('Day 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayFourPage()),
                );
              },
              child: const Text('Day 4'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayFivePage()),
                );
              },
              child: const Text('Day 5'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaySixPage()),
                );
              },
              child: const Text('Day 6'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaySevenPage()),
                );
              },
              child: const Text('Day 7'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayEightPage()),
                );
              },
              child: const Text('Day 8'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayNinePage()),
                );
              },
              child: const Text('Day 9'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DayTenPage()),
                );
              },
              child: const Text('Day 10'),
            ),
            // Add more buttons for other pages
          ],
        ),
      ),
    );
  }
}