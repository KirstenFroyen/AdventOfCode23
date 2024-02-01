// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayOnePage extends StatefulWidget {
  const DayOnePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DayOnePageState createState() => _DayOnePageState();
}

class _DayOnePageState extends State<DayOnePage> {
  int totalSum = 0;

  @override
  void initState() {
    super.initState();
    loadCalibrationValues();
  }

  Future<int> loadCalibrationValues() async {
  try {
    // Load the contents of the text file
    String contents = await rootBundle.loadString('lib/assets/input/day1/puzzleInput.txt');

    // Split the contents into lines
    List<String> lines = contents.split('\n');

    // Calculate the sum of calibration values
    int sum = 0;
    for (String line in lines) {
      if (line.isNotEmpty) {
        // Remove non-numeric characters and convert to a list of integers
        List<int> numbers = line.replaceAll(RegExp(r'[^0-9]'), '')
                                  .split('')
                                  .map(int.parse)
                                  .toList();

        // Ensure we have at least one number
        if (numbers.isNotEmpty) {
          // Extract the first and last numbers
          int firstNumber = numbers.first;
          int lastNumber = numbers.length == 1 ? firstNumber : numbers.last;

          // Combine the first and last numbers to form a two-digit number
          int calibrationValue = firstNumber * 10 + lastNumber;

          // Add the calibration value to the sum
          sum += calibrationValue;
        }
      }
    }

    return sum;
  } catch (e) {
    print('Error loading calibration values: $e');
    return 0;
  }
}

Future<int> loadCalibrationValuesPart2() async {
  try {
    // Load the contents of the text file
    String contents = await rootBundle.loadString('lib/assets/input/day1/puzzleInput.txt');

    // Define a map to convert word representations to digits
    Map<String, int> wordToDigit = {
      'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5,
      'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    };

    // Calculate the sum of calibration values
    int sum = 0;

    // Split the contents into lines
    List<String> lines = contents.split('\n');

    // Iterate over each line
    for (String line in lines) {
      // Initialize first and last numbers
      int firstNumber = 0, lastNumber = 0;

      // Initialize variable to keep track of the current token
      String currentToken = '';

      // Iterate through each character in the line
      for (int i = 0; i < line.length; i++) {
        String currentChar = line[i];

        // Check if the current character is alphanumeric
        if (RegExp(r'[a-zA-Z0-9]').hasMatch(currentChar)) {
          currentToken += currentChar;
        } 
          // If the current token is not empty, process it
          if (currentToken.isNotEmpty) {
            int parsedNumber = _convertTokenToNumber(currentToken, wordToDigit);
            if (parsedNumber != 0){
              if (firstNumber == 0) {
                firstNumber = parsedNumber;
              }
              lastNumber = parsedNumber;
              currentToken = currentToken.substring(currentToken.length - 1); 
            }// Reset the token for the next one
          }
      }

      // If there's a remaining token at the end of the line, process it
      if (currentToken.isNotEmpty) {
        int parsedNumber = _convertTokenToNumber(currentToken, wordToDigit);
        if (parsedNumber != 0) {
          if (firstNumber == 0) {
            firstNumber = parsedNumber;
          }
          lastNumber = parsedNumber;
        }
      }

      // Calculate the calibration value and add it to the sum
      int calibrationValue = firstNumber * 10 + lastNumber;
      sum += calibrationValue;
    }

    return sum;
  } catch (e) {
    print('Error loading calibration values: $e');
    return 0;
  }
}

// Helper function to convert a token to a number
int _convertTokenToNumber(String token, Map<String, int> wordToDigit) {
  int parsed = 0;

  if (token.contains(RegExp(r'[0-9]'))) {
    for (int i = 0; i < token.length; i++) {
      if (int.tryParse(token[i])!=null) {
        parsed = int.parse(token[i]);
      }
    }
  }
  else {
    wordToDigit.forEach((key, value) => {
      if (token.contains(key)) {
        parsed = value
      }
    });
  }
  return parsed;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibration Sum'),
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: loadCalibrationValues(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading data');
              } else {
                return Text(
                  'Sum of all calibration values: ${snapshot.data}',
                  style: const TextStyle(fontSize: 18),
                );
              }
            },
          ),
          FutureBuilder<int>(
            future: loadCalibrationValuesPart2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading data');
              } else {
                return Text(
                  'Sum of all calibration values for part 2: ${snapshot.data}',
                  style: const TextStyle(fontSize: 18),
                );
              }
            },
          )
        ],
      ),
    );
  }
}