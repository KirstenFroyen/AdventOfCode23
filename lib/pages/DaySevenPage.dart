// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:advent_of_code_23/services/FileReader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DaySevenPage extends StatefulWidget {
  const DaySevenPage({Key? key}) : super(key: key);

  @override
  _DaySevenPageState createState() => _DaySevenPageState();
}

class _DaySevenPageState extends State<DaySevenPage> {

  late Future<int> _partOne;
  late Future<int> _partTwo;
  static const List<String> _playingCards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];

  @override
  void initState() {
    super.initState();
    _partOne = _findPartOne();
    _partTwo = _findPartTwo();
  }

  Future<int> _findPartOne() async {
    List<String> lines = await FileReader.readFileLines("day7/puzzleInput.txt");
    return totalWinnings(lines);
  }

  Future<int> _findPartTwo() async {
    List<String> lines = await FileReader.readFileLines("day7/testInput.txt");
    return lines.length;
  }

  int totalWinnings(List<String> input) {
    var hands = _parseHands(input);

    hands.sort((a, b) => compareHands(a, b));

    int totalWinnings = 0;

    for (int i = 0; i < hands.length; i++) {
      totalWinnings += hands[i].bid * (i + 1);
    }

    return totalWinnings;
  }

  List<Hand> _parseHands(List<String> input) {
    List<Hand> hands = [];
    for (String line in input) {
      var splitLine = line.split(" ");
      hands.add(Hand(splitLine[0].split(""), int.parse(splitLine[1])));
    }

    return hands;
  }

  int cardValue(String card) {
    return 14 - _playingCards.indexOf(card);
  }

  List<int> cardValues(List<String> cards) {
    return cards.map((card) => cardValue(card)).toList();
  }

  int compareHands(Hand a, Hand b) {
    if (a.type != b.type) {
      return a.type.index.compareTo(b.type.index);
    } else {
      var aValues = cardValues(a.cards);
      var bValues = cardValues(b.cards);

      for (int i = 0; i < aValues.length; i++) {
        if (aValues[i] != bValues[i]) {
          return aValues[i].compareTo(bValues[i]);
        }
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Seven'),
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

class Hand {
  final List<String> cards;
  final int bid;

  Hand(this.cards, this.bid);

  HandType get type => _handType(cards);
}

enum HandType {
  highCard,
  onePair,
  twoPair,
  threeOfAKind,
  fullHouse,
  fourOfAKind,
  fiveOfAKind,
}

HandType _handType(List<String> cards) {
  var counts = <String, int>{};

  for (var card in cards) {
    counts[card] = (counts[card] ?? 0) + 1;
  }

  var countValues = counts.values.toList()..sort((a, b) => b - a);

  if (countValues[0] == 5) return HandType.fiveOfAKind;
  if (countValues[0] == 4) return HandType.fourOfAKind;
  if (countValues[0] == 3 && countValues[1] == 2) return HandType.fullHouse;
  if (countValues[0] == 3) return HandType.threeOfAKind;
  if (countValues[0] == 2 && countValues[1] == 2) return HandType.twoPair;
  if (countValues[0] == 2) return HandType.onePair;
  return HandType.highCard;
}