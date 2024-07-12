// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DayEightPage extends StatefulWidget {
  const DayEightPage({Key? key}) : super(key: key);

  @override
  _DayEightPageState createState() => _DayEightPageState();
}

class _DayEightPageState extends State<DayEightPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day8/puzzleInput.txt");
    return calculateSteps(lines);
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day8/testInput.txt");
    return lines.length;
  }

  int calculateSteps(List<String> input) {
    String directions = input.removeAt(0).trim();
    final pattern = RegExp(r'(\w+)\s*=\s*\((\w+),\s*(\w+)\)');
    final matches = pattern.allMatches(input.join('\n'));

    directions = (directions * input.length);

    List<Node> nodes = matches.map((match) {
      final start = match.group(1)!;
      final nextElements = [match.group(2)!, match.group(3)!];

      return Node(start, nextElements);
    }).toList();

    Node currentNode = nodes.firstWhere((element) => element.start == "AAA");
    int steps = 0;

    directions.split('').forEach((element) {
      String destinationNode = "";
      if (currentNode.start != "ZZZ") {
        if (element == "R") {
          destinationNode = currentNode.nextElements[1];
        } else {
          destinationNode = currentNode.nextElements[0];
        }
        steps++;
        currentNode = nodes.firstWhere((element) => element.start == destinationNode);
      }
    });

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Eight'),
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

class Node {
  final String start;
  final List<String> nextElements;

  Node(this.start, this.nextElements);
}