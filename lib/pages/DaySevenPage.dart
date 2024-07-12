// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DaySevenPage extends StatefulWidget {
  const DaySevenPage({Key? key}) : super(key: key);

  @override
  _DaySevenPageState createState() => _DaySevenPageState();
}

class _DaySevenPageState extends State<DaySevenPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day7/testInput.txt");
    return lines.length;
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day7/testInput.txt");
    return lines.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Seven'),
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: _partOne,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'Part one:\n${snapshot.data}',
                    style: const TextStyle(fontSize: 20),
                  );
                }
              }
            },
          ),
          FutureBuilder<int>(
            future: _partTwo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'Part two:\n${snapshot.data}',
                    style: const TextStyle(fontSize: 20),
                  );
                }
              }
            },
          ),
        ]
      ),
    );
  }
}