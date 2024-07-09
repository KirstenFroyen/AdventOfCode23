// ignore_for_file: file_names

import 'dart:math';

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DayFivePage extends StatefulWidget {
  const DayFivePage({Key? key}) : super(key: key);

  @override
  _DayFivePageState createState() => _DayFivePageState();
}

class _DayFivePageState extends State<DayFivePage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findLocation();
    _partTwo = _seedRanges();
  }

  Future<int> _findLocation() async {
    List<String> lines = await FileReader.readFileLines("day5/puzzleInput.txt");
    return findLowestLocationNumber(lines);
  }

  Future<int> _seedRanges() async {
    List<String> lines = await FileReader.readFileLines("day5/testInput.txt");
    return findPartTwo(lines);
  }

  int findLowestLocationNumber(List<String> input) {
    List<String> segments = input;
    List<int> seeds = RegExp(r'\d+').allMatches(segments[0]).map((e) => int.parse(e.group(0)!)).toList();

    int minLocation = double.maxFinite.toInt();
    for (int x in seeds) {
      for (String seg in segments.sublist(1)) {
        for (RegExpMatch match in RegExp(r'(\d+) (\d+) (\d+)').allMatches(seg)) {
          int destination = int.parse(match.group(1)!);
          int start = int.parse(match.group(2)!);
          int delta = int.parse(match.group(3)!);
          if (x >= start && x < start + delta) {
            x += destination - start;
            break;
          }
        }
      }
      minLocation = min(x, minLocation);
    }
    return minLocation;
  }

  int findPartTwo(List<String> input) {
    List<String> segments = input;
    List<Tuple> intervals = [];

    RegExp seedExp = RegExp(r'(\d+) (\d+)');
    for (RegExpMatch match in seedExp.allMatches(segments[0])) {
      int x1 = int.parse(match.group(1)!);
      int dx = int.parse(match.group(2)!);
      int x2 = x1 + dx;
      intervals.add(Tuple(x1, x2, 1));
    }

    int minLocation = double.maxFinite.toInt();
    while (intervals.isNotEmpty) {
      Tuple interval = intervals.removeLast();
      int x1 = interval.x1;
      int x2 = interval.x2;
      int level = interval.level;

      if (level == 8) {
        minLocation = min(x1, minLocation);
        continue;
      }

      RegExp conversionExp = RegExp(r'(\d+) (\d+) (\d+)');
      for (RegExpMatch match in conversionExp.allMatches(segments[level])) {
        int z = int.parse(match.group(1)!);
        int y1 = int.parse(match.group(2)!);
        int dy = int.parse(match.group(3)!);
        int y2 = y1 + dy;
        int diff = z - y1;

        if (x2 <= y1 || y2 <= x1) {
          continue;
        }
        if (x1 < y1) {
          intervals.add(Tuple(x1, y1, level));
          x1 = y1;
        }
        if (y2 < x2) {
          intervals.add(Tuple(y2, x2, level));
          x2 = y2;
        }
        intervals.add(Tuple(x1 + diff, x2 + diff, level + 1));
        break;
      }
      intervals.add(Tuple(x1, x2, level + 1));
    }

    return minLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Five'),
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

class Tuple {
  final int x1;
  final int x2;
  final int level;

  Tuple(this.x1, this.x2, this.level);
}