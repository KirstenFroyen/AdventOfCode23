// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DayFourPage extends StatefulWidget {
  const DayFourPage({Key? key}) : super(key: key);

  @override
  _DayFourPageState createState() => _DayFourPageState();
}

class _DayFourPageState extends State<DayFourPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;

  @override
  void initState() {
    super.initState();
    _partOne = _calculatePoints();
    _partTwo = _calculateScratchcards();
  }

  Future<int> _calculatePoints() async {
    List<String> lines = await FileReader.readFileLines("day4/puzzleInput.txt");
    return calculateTotalPoints(lines);
  }

  Future<int> _calculateScratchcards() async {
    List<String> lines = await FileReader.readFileLines("day4/puzzleInput.txt");
    return calculateTotalCards(lines);
  }

  int calculateTotalPoints(List<String> input) {
    var cards = parseCards(input);
    int sum = 0;

    for (var card in cards) {
      var winning = card.winningNumbers.toSet();
      var mine = card.myNumbers.toSet();
      var cardSum = 0;

      var myWinningNumbers = winning.intersection(mine);

      if (myWinningNumbers.isNotEmpty) {
        cardSum = 1;
      }

      for (var i = 1; i < myWinningNumbers.length; i++) {
        cardSum *= 2;
      }

      sum += cardSum;
    }

    return sum;
  }

  /*int calculateTotalCards(List<String> input) {
    var cards = parseCards(input);
    int totalCards = cards.length;
    Queue<ScratchCard> queue = Queue<ScratchCard>();
    queue.addAll(cards);

    while(queue.isNotEmpty) {
      ScratchCard current = queue.removeFirst();

      int matches = current.countMatches();

      for (int i = 1; i <= matches; i++) {
        if (current.cardNumber - 1 + i < cards.length) {
          var next = cards[current.cardNumber - 1 + i];
          queue.add(next);
          totalCards++;
        }
      }
    }

    return totalCards;
  }*/

  int calculateTotalCards(List<String> input) {
    var cards = parseCards(input);
    int totalCards = cards.length;

    // Array to keep track of scratchcard counts
    List<int> cardCounts = List<int>.filled(cards.length, 1); // Start with 1 instance of each card

    for (int i = 0; i < cards.length; i++) {
      ScratchCard current = cards[i];
      int matches = current.countMatches();

      for (int j = 1; j <= matches; j++) {
        if (i + j < cards.length) {
          cardCounts[i + j] += cardCounts[i]; // Add copies to the subsequent card
          totalCards += cardCounts[i]; // Add to the total count
        }
      }
    }

    return totalCards;
  }

  List<ScratchCard> parseCards(List<String> input) {
    List<ScratchCard> cards = [];

    for (var line in input) {
      var parts = line.split(": ");
      var cardNumber = int.parse(parts[0].substring(parts[0].length-1));

      var numbers = parts[1].split(" | ");
      var winningNumbers = numbers[0].split(" ").where((e) => e.isNotEmpty).map(int.parse).toList();
      var myNumbers = numbers[1].split(" ").where((e) => e.isNotEmpty).map(int.parse).toList();

      cards.add(ScratchCard(cardNumber, winningNumbers, myNumbers));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Four'),
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

class ScratchCard {
  final int cardNumber;
  final List<int> winningNumbers;
  final List<int> myNumbers;

  ScratchCard(this.cardNumber, this.winningNumbers, this.myNumbers);

  int countMatches() {
    return winningNumbers.where((number) => myNumbers.contains(number)).length;
  }
}