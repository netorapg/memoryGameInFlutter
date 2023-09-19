import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: MemoryGame(),
      );
  }
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> items= ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];  
  List<bool> isFlipped = List<bool>.generate(16, ((index) => false));
  int firstCardIndex = -1;
  int secondCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          return FlipCard(
            onFlip: () {
              if (!isFlipped[index]) {
                setState(() {
                  isFlipped[index] = true;
                });
                if (firstCardIndex == -1) {
                  firstCardIndex = index;
                } else {
                  secondCardIndex = index;
                  if (items[firstCardIndex] != items[secondCardIndex]) {
                    Future.delayed (const Duration(seconds: 1), () {
                      setState (() {
                        isFlipped[firstCardIndex] = false;
                        isFlipped[secondCardIndex] = false;
                        firstCardIndex = -1;
                        secondCardIndex = -1;
                      });
                    });
                  } else {
                    firstCardIndex = -1;
                    secondCardIndex = -1;
                  }
                }
                }
              },
              direction: FlipDirection.HORIZONTAL,
              flipOnTouch: !isFlipped[index],
              front: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '?',
                    style: TextStyle(fontSize: 48.0),
                  ),
                ),
              ),
              back:Container(
                color: Colors.green,
                child: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(fontSize: 48.0),
                  ),
                  ),
              ),
          );
        },
      ),
    );
  }
}