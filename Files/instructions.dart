import 'dart:async';
import 'package:flutter/material.dart';
import 'circle_widget.dart'; // Import your CircleWidget
import 'game_screen.dart';  // Import your GameScreen

class InstructionsPage extends StatefulWidget {
  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  int _currentCircle = -1;  // Start with no circle lit up
  Timer? _timer;
  final int totalCircles = 4;  // Number of circles
  double _cursorX = 0;  // Cursor's starting X position
  double _cursorY = 0;  // Cursor's starting Y position
  final double _cursorSize = 40;  // Size of the cursor
  List<Offset> _circlePositions = [];  // Store circle positions to move the cursor

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setCirclePositions();  // Set circle positions after the layout is built
      _startAnimation();      // Start the cursor and circle animation after layout is complete
    });
  }

  void _setCirclePositions() {
    // Set circle positions dynamically after the screen is rendered
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _circlePositions = [
        Offset(100, 100),  // Top-left
        Offset(screenWidth - 200, 100),  // Top-right
        Offset(100, 330),  // Bottom-left
        Offset(screenWidth - 200, 330),  // Bottom-right
      ];
    });
  }

  void _startAnimation() {
    // Start the animation that lights up circles and moves the cursor
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        if (_currentCircle < totalCircles - 1) {
          _currentCircle++;  // Move to the next circle
        } else {
          _currentCircle = 0;  // Restart the loop after all circles have lit up
        }

        // Move the cursor to the center of the current circle
        _cursorX = _circlePositions[_currentCircle].dx - (_cursorSize / 2);  // Adjust X to center
        _cursorY = _circlePositions[_currentCircle].dy - (_cursorSize / 2);  // Adjust Y to center
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();  // Clean up the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'How to Play the Game:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1. Follow the animation below to understand where to tap.\n'
              '2. The cursor (black dot) will show you the order in which the circles will light up.\n'
              '3. Once you start the game, tap the circles in the same order as shown.\n'
              '4. Your score will depend on how closely your taps match the rhythm.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Instructions for tapping the circles
                Positioned(
                  left: _cursorX,  // Cursor's adjusted X position
                  top: _cursorY,   // Cursor's adjusted Y position
                  child: Container(
                    width: _cursorSize,
                    height: _cursorSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 0, 0, 0),  // Cursor color
                    ),
                  ),
                ),
                // Top-left circle
                Positioned(
                  left: 100,
                  top: 100,
                  child: CircleWidget(
                    isActive: _currentCircle == 0,
                    onTap: null,  // No interaction
                  ),
                ),
                // Top-right circle
                Positioned(
                  right: 100,
                  top: 100,
                  child: CircleWidget(
                    isActive: _currentCircle == 1,
                    onTap: null,  // No interaction
                  ),
                ),
                // Bottom-left circle
                Positioned(
                  left: 100,
                  bottom: 100,
                  child: CircleWidget(
                    isActive: _currentCircle == 2,
                    onTap: null,  // No interaction
                  ),
                ),
                // Bottom-right circle
                Positioned(
                  right: 100,
                  bottom: 100,
                  child: CircleWidget(
                    isActive: _currentCircle == 3,
                    onTap: null,  // No interaction
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to GameScreen to start the actual game
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(bpm: 120),  // Pass in your desired BPM
                  ),
                );
              },
              child: Text('Start Game'),
            ),
          ),
        ],
      ),
    );
  }
}
