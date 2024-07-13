// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DayNinePage extends StatefulWidget {
  const DayNinePage({Key? key}) : super(key: key);

  @override
  _DayNinePageState createState() => _DayNinePageState();
}

class _DayNinePageState extends State<DayNinePage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day9/puzzleInput.txt");
    return calculateExtrapolatedValues(lines);
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day9/puzzleInput.txt");
    return extrapolateBackwards(lines);
  }

  int calculateExtrapolatedValues(List<String> input) {
    List<List<int>> histories = [];

    for (var line in input) {
      histories.add(line.split(' ').map((e) => int.parse(e)).toList());
    }

    return sumOfNextValues(histories);
  }

  int extrapolateBackwards(List<String> input) {
    List<List<int>> histories = [];

    for (var line in input) {
      histories.add(line.split(' ').map((e) => int.parse(e)).toList().reversed.toList());
    }

    return sumOfNextValues(histories);
  }

  int nextValue(List<int> sequence) {
    List<int> diff(List<int> seq) {
      List<int> result = [];
      for (int i = 0; i < seq.length -1 ; i++) {
        result.add(seq[i + 1] - seq[i]);
      }

      return result;
    }

    List<List<int>> allDiffs = [sequence];

    while (true) {
      List<int> lastDiff = diff(allDiffs.last);
      allDiffs.add(lastDiff);

      if(lastDiff.every((element) => element == 0)) {
        break;
      }
    }

    for (int i = allDiffs.length - 1; i >= 0; i--) {
      if (i + 1 >= allDiffs.length) {
        allDiffs[i].add(allDiffs[i].last);
      } else {
        allDiffs[i].add(allDiffs[i].last + allDiffs[i + 1].last);
      }
    }

    return allDiffs[0].last;
  }

  int sumOfNextValues(List<List<int>> histories) {
    int sum = 0;

    for (List<int> history in histories) {
      sum += nextValue(history);
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Nine'),
      ),
      body: Center(
        child: Column(
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
      )
    );
  }
}