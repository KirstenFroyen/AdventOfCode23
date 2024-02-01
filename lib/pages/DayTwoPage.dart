import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';

class DayTwoPage extends StatefulWidget {
  const DayTwoPage({Key? key}) : super(key: key);

  @override
  _DayTwoPageState createState() => _DayTwoPageState();
}

class _DayTwoPageState extends State<DayTwoPage> {
  // Cube counts
  static const int redCubes = 12;
  static const int greenCubes = 13;
  static const int blueCubes = 14;

  late Future<int> _sumOfIDsFuture;
  late Future<int> _sumOfPowerOfCubes;

  @override
  void initState() {
    super.initState();
    _sumOfIDsFuture = _calculateSumOfIDs();
    _sumOfPowerOfCubes = _calculateSumOfPowerOfCubes();
  }

  Future<int> _calculateSumOfIDs() async {
    List<String> lines = await FileReader.readFileLines("day2/puzzleInput.txt");
    List<int> possibleGames = _determinePossibleGames(lines);
    return _calculateSumOfIDsHelper(possibleGames);
  }

  Future<int> _calculateSumOfPowerOfCubes() async {
    List<String> lines = await FileReader.readFileLines("day2/puzzleInput.txt");
    List<int> powerOfcubes = _determinePowerOfCubes(lines);
    return _calculateSumOfPowerOfCubesHelper(powerOfcubes);
  }

  List<int> _determinePossibleGames(List<String> gameRecords) {
    List<int> possibleGames = [];

    for (String record in gameRecords) {
      bool isPossible = true;
      List<String> subsets = record.substring(record.indexOf(":") + 2).split(';');

      for (String subset in subsets) {
        List<String> cubes = subset.split(',').map((e) => e.trim()).toList();

        for (String cube in cubes) {
          List<String> parts = cube.split(' ');
          int? count = int.tryParse(parts[0]);
          String color = parts[1];

          if (count == null || (color == 'red' && count > redCubes) ||
              (color == 'green' && count > greenCubes) ||
              (color == 'blue' && count > blueCubes)) {
            isPossible = false;
            break;
          }
        }

        if (!isPossible) {
          break;
        }
      }

      if (isPossible) {
        // Extract game ID from the record
        int gameId = int.tryParse(record.split(':')[0].split(' ')[1]) ?? 0;
        if (gameId != 0) {
          possibleGames.add(gameId);
        }
      }
    }

    return possibleGames;
  }

  List<int> _determinePowerOfCubes(List<String> records) {
    List<int> power = [];

    for (String record in records) {
      List<String> subsets = record.substring(record.indexOf(":") + 2).split(';');
      int highestRed = 0;
      int highestGreen = 0;
      int highestBlue = 0;

      for (String subset in subsets) {
        List<String> cubes = subset.split(',').map((e) => e.trim()).toList();

        for (String cube in cubes) {
          List<String> parts = cube.split(' ');
          int? count = int.tryParse(parts[0]);
          String color = parts[1];

          if (color == 'red' && count! > highestRed) {
            highestRed = count;
          } else if (color == 'blue' && count! > highestBlue) {
            highestBlue = count;
          } else if (color == 'green' && count! > highestGreen) {
            highestGreen = count;
          }
        }
      }

      power.add(highestRed * highestBlue * highestGreen);
    }

    return power;
  }

  int _calculateSumOfIDsHelper(List<int> possibleGames) {
    int sum = 0;
    for (int gameId in possibleGames) {
      sum += gameId;
    }
    return sum;
  }

  int _calculateSumOfPowerOfCubesHelper(List<int> power) {
    int sum = 0;
    for (int value in power) {
      sum += value;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Two'),
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: _sumOfIDsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'The sum of IDs of possible games is: ${snapshot.data}',
                    style: TextStyle(fontSize: 20),
                  );
                }
              }
            },
          ),
          FutureBuilder<int>(
            future: _sumOfPowerOfCubes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'The sum of power of possible cubes is: ${snapshot.data}',
                    style: TextStyle(fontSize: 20),
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
