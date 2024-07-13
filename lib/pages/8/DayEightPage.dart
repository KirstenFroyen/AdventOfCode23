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
    List<String> lines = await FileReader.readFileLines("day8/puzzleInput.txt");
    return calculateGhostSteps(lines);
  }

  int calculateSteps(List<String> input) {
    String directions = input.removeAt(0).trim();

    directions = (directions * input.length);

    List<Node> nodes = _parseNodes(input);

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

  int gcd(int a, int b) {
    while (b != 0) {
      int t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  int lcm(int a, int b) => (a * b) ~/ gcd(a, b);

  int calculateGhostSteps(List<String> input) {
    String directionString = input.removeAt(0).trim();
    List<Node> nodes = _parseNodes(input);

    Map<String, Node> nodeMap = {for (var node in nodes) node.start: node};

    List<Node> startingNodes = nodes.where((node) => node.start.endsWith("A")).toList();
    List<int> cycles = [];

    List<int> directions = directionString.split('').map((d) => d == 'L' ? 0 : 1).toList();
    int directionsLength = directions.length;

    for (var node in startingNodes) {
      String currentNode = node.start;
      int steps = 0;

      do {
        int direction = directions[steps % directionsLength];
        currentNode = nodeMap[currentNode]!.nextElements[direction];
        steps++;
      } while (!currentNode.endsWith("Z"));

      cycles.add(steps);
    }

    int result = cycles.fold(1, (value, element) => lcm(value, element));
    return result;
  }

  List<Node> _parseNodes(List<String> input) {
    final pattern = RegExp(r'(\w+)\s*=\s*\((\w+),\s*(\w+)\)');
    final matches = pattern.allMatches(input.join('\n'));

    List<Node> nodes = matches.map((match) {
      final start = match.group(1)!;
      final nextElements = [match.group(2)!, match.group(3)!];

      return Node(start, nextElements);
    }).toList();

    return nodes;
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