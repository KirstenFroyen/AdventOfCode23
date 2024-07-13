// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DayThreePage extends StatefulWidget {
  const DayThreePage({Key? key}) : super(key: key);

  @override
  _DayThreePageState createState() => _DayThreePageState();
}

class _DayThreePageState extends State<DayThreePage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _calculateSumOfPartNumbers();
    _partTwo = _calculateRatio();
  }

  Future<int> _calculateSumOfPartNumbers() async {
    List<String> lines = await FileReader.readFileLines("day3/puzzleInput.txt");
    return sumOfPartNumbers(lines);
  }

  Future<int> _calculateRatio() async {
    List<String> lines = await FileReader.readFileLines("day3/puzzleInput.txt");
    return calculateRatio(lines);
  }

  int sumOfPartNumbers(List<String> engineSchematic) {
    Lists lists = Lists(engineSchematic);
    lists.initiateLists();
    
    var symbols = lists.symbols;
    var numbers = lists.numbers;

    var partSum = numbers
      .where((n) => symbols.any((s) => s.pos.isAdjacent(n)))
      .fold(0, (sum, n) => sum + n.value);

    return partSum;
  }

  int calculateRatio(List<String> engineSchematic) {
    Lists lists = Lists(engineSchematic);
    lists.initiateLists();
    
    var symbols = lists.symbols.toSet().toList(); 
    var numbers = lists.numbers;

    var ratio = symbols
      .where((s) => s.value == "*")
      .fold(0, (sum, g) {
        var adjacentNumbers = numbers.where((n) => g.pos.isAdjacent(n)).toList();
        return adjacentNumbers.length == 2
          ? sum + adjacentNumbers.fold(1, (acc, n) => acc * n.value)
          : sum;
    });

    return ratio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Three'),
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

class Lists {
  final symbols = <Symbol>[];
  final numbers = <Number>[];
  final List<String> engineSchematic;

  Lists(this.engineSchematic);

  void initiateLists() {
    var numberRegex = RegExp(r'\d+');
    var symbolRegex = RegExp(r'[^\.\d\n]');

    var lineNum = 0;
    for (var line in engineSchematic) {
      for (var nm in numberRegex.allMatches(line)) {
        numbers.add(Number(
          int.parse(nm.group(0)!),
          Pos(lineNum, nm.start, nm.end - 1)
        ));
      }

      for (var sm in symbolRegex.allMatches(line)) {
        if (sm.start < line.length - 1) {
          symbols.add(Symbol(
            sm.group(0)!, 
            Pos(lineNum, sm.start, sm.start)
          ));
        }
      }

      lineNum++;
    }
  }
}

class Pos {
  final int row;
  final int colStart;
  final int colEnd;

  Pos(this.row, this.colStart, this.colEnd);

  bool isAdjacent(Number number) {
    if (row < number.pos.row - 1 || row > number.pos.row + 1) {
      return false;
    }
    return colStart >= number.pos.colStart - 1 && colStart <= number.pos.colEnd + 1;
  }
}

class Symbol {
  final String value;
  final Pos pos;

  Symbol(this.value, this.pos);
}

class Number {
  final int value;
  final Pos pos;

  Number(this.value, this.pos);
}
