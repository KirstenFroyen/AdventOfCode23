// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DaySixPage extends StatefulWidget {
  const DaySixPage({Key? key}) : super(key: key);

  @override
  _DaySixPageState createState() => _DaySixPageState();
}

class _DaySixPageState extends State<DaySixPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day6/puzzleInput.txt");
    return beatTheRecords(lines);
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day6/puzzleInput.txt");
    return beatTheRace(lines);
  }

  int beatTheRecords(List<String> input) {
    List<Race> races = _parseDataPartOne(input);

    int result = 1;
    for (Race race in races) {
      int wins = race.possibleWins();
      result *= wins;
    }

    return result;
  }

  int beatTheRace(List<String> input) {
    Race race = _parseRaceData(input);

    return race.possibleWins();
  }

  List<Race> _parseDataPartOne(List<String> lines) {
    List<int> times = lines[0]
      .replaceAll("Time:", "")
      .trim()
      .split(RegExp(r'\s+'))
      .map(int.parse)
      .toList();

    List<int> distances = lines[1]
      .replaceAll("Distance:", "")
      .trim()
      .split(RegExp(r'\s+'))
      .map(int.parse)
      .toList();

    List<Race> races = [];
    for (int i = 0; i < times.length; i++) {
      races.add(Race(times[i], distances[i]));
    }

    return races;
  }

  Race _parseRaceData(List<String> lines) {
    return Race(int.parse(lines[0].split(RegExp(r'\s+')).skip(1).join()), int.parse(lines[1].split(RegExp(r'\s+')).skip(1).join()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Six'),
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
                  final formattedResult = NumberFormat.decimalPattern('nl').format(snapshot.data);
                  return Text(
                    'Part one:\n$formattedResult',
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
                  final formattedResult = NumberFormat.decimalPattern('nl').format(snapshot.data);
                  return Text(
                    'Part two:\n$formattedResult',
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

class Race {
  final int milliseconds;
  final int record;

  Race(this.milliseconds, this.record);

  int possibleWins() {
    int sum = 0;

    for (int i = 0; i <= milliseconds; i++) {
      int remainingTime = milliseconds - i;
      int distance = remainingTime * i;

      if (distance > record) {
        sum++;
      }
    }

    return sum;
  }
}