// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DayTenPage extends StatefulWidget {
  const DayTenPage({Key? key}) : super(key: key);

  @override
  _DayTenPageState createState() => _DayTenPageState();
}

class _DayTenPageState extends State<DayTenPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day10/puzzleInput.txt");
    return calculateSteps(lines);
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day10/testInput.txt");
    return lines.length;
  }

  int calculateSteps(List<String> input) {
    List<String> grid = input;
    Map<String, List<String>> graph = {};
    Set<String> visited = {};
    Set<String> q = {};

    for (int x = 0; x < grid.length; x++) {
      String line = grid[x].trim();

      for (int y = 0; y < line.length; y++) {
        String tile = line[y];
        
        if (tile != '.') {
          List<String> adjacent = [];

          if ('-J7S'.contains(tile)) {
            adjacent.add("$x,${y-1}");
          }
          if ('-FLS'.contains(tile)) {
            adjacent.add("$x,${y+1}");
          }
          if ('|F7S'.contains(tile)) {
            adjacent.add("${x+1},$y");
          }
          if ('|LJS'.contains(tile)) {
            adjacent.add("${x-1},$y");
          }
          if (tile == 'S') {
            visited.add('$x,$y');
            q.add('$x,$y');
          }

          graph['$x,$y'] = adjacent;
        }
      }
    }

    int steps = -1;

    while (q.isNotEmpty) {
      Set<String> nxt = {};

      for (String pos in q) {

        if (graph.containsKey(pos)) {
          for (String adj in graph[pos]!) {
            List<int> adjXY = adj.split(',').map(int.parse).toList();
            int x2 = adjXY[0];
            int y2 = adjXY[1];
            String adjKey = '$x2,$y2';

            if (!visited.contains(adjKey) && graph.containsKey(adjKey) && graph[adjKey]!.contains(pos)) {
              nxt.add(adjKey);
              visited.add(adjKey);
            }
          }
        }
      }

      q = nxt;
      steps++;
    }

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Ten'),
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