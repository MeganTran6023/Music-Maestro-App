import 'dart:async';
import 'package:flutter/material.dart';
import 'circle_widget.dart';
import 'result_screen.dart'; // Import the ResultScreen

class GameScreen extends StatefulWidget {
  final int bpm; // Pass the BPM to control the speed of the game

  GameScreen({Key? key, required this.bpm}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentCircle = 0; // Track the current visible circle
  Timer? _timer;
  List<int> _tapTimes = []; // Store the timestamps of the user's taps
  List<int> _pattern = []; // Store the sequence of circles shown
  int _userIndex = 0; // Track how many circles the user has tapped
  bool _showPatternComplete = false; // Track if the pattern has been shown
  List<int> _expectedTimes = []; // Store the expected tap times based on BPM

  @override
  void initState() {
    super.initState();

    // Delay the game start by 500 milliseconds after the screen is fully rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        _startGame(); // Start the game after the screen is fully rendered and after a delay
      });
    });
  }

  void _startGame() {
    // Reset all variables for a new game
    setState(() {
      _currentCircle = 0;
      _tapTimes = [];
      _pattern = [];
      _userIndex = 0;
      _showPatternComplete = false;
      _expectedTimes = [];
    });

    // Calculate interval in milliseconds from BPM
    int intervalMs = (60000 / widget.bpm).round();

    // Start a timer that updates the visible circle at the BPM interval
    _timer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      setState(() {
        if (_currentCircle < 4) { // Only show each circle once
          _pattern.add(_currentCircle); // Add to the pattern sequence
          _expectedTimes.add(DateTime.now().millisecondsSinceEpoch); // Record the expected time for this circle
          _currentCircle++;
        } else {
          _timer?.cancel(); // Stop the timer after all circles are shown
          _showPatternComplete = true; // Mark that the pattern is complete
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Calculate user BPM based on their tap times
  double _calculateUserBpm() {
    if (_tapTimes.length < 2) return 0; // Not enough taps to calculate BPM

    List<int> intervals = [];
    for (int i = 1; i < _tapTimes.length; i++) {
      intervals.add(_tapTimes[i] - _tapTimes[i - 1]);
    }

    // Calculate the average interval in milliseconds
    double avgInterval = intervals.reduce((a, b) => a + b) / intervals.length;

    // Convert the interval back to BPM
    return 60000 / avgInterval;
  }

  void _handleTap(int circleIndex) {
  if (!_showPatternComplete) return; // Do nothing if the pattern is not complete yet

  int currentTime = DateTime.now().millisecondsSinceEpoch;

  // Compare the user's tap to the pattern
  if (_pattern[_userIndex] == circleIndex) {
    // Record the user's tap time
    _tapTimes.add(currentTime);
    
    _userIndex++; // Move to the next circle in the pattern

    // Check if the user has completed the pattern
    if (_userIndex == _pattern.length) {
      // Calculate the user's BPM
      double userBpm = _calculateUserBpm();

      // Navigate to the ResultScreen and wait for the result
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            originalBpm: widget.bpm,
            userBpm: userBpm,
          ),
        ),
      ).then((result) {
        if (result == true) {
          // User wants to retry, cancel any ongoing timer and restart the game
          _timer?.cancel();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration(milliseconds: 500), () {
              _startGame(); // Restart the game after the screen is fully rendered and after a delay
            });
          });
        }
      });
    }
  } 
  // The else block has been removed, so nothing happens if the user taps the wrong circle
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 177, 252),
      body: Center(
        child: Stack(
          children: [
            // Top-left circle
            Positioned(
              left: 200,
              top: 200,
              child: GestureDetector(
                onTap: () => _handleTap(0),  // Make circles tappable
                child: CircleWidget(
                  isActive: _currentCircle == 0 && !_showPatternComplete,
                ),
              ),
            ),
            // Top-right circle
            Positioned(
              right: 200,
              top: 200,
              child: GestureDetector(
                onTap: () => _handleTap(1),  // Make circles tappable
                child: CircleWidget(
                  isActive: _currentCircle == 1 && !_showPatternComplete,
                ),
              ),
            ),
            // Bottom-left circle
            Positioned(
              left: 200,
              bottom: 200,
              child: GestureDetector(
                onTap: () => _handleTap(2),  // Make circles tappable
                child: CircleWidget(
                  isActive: _currentCircle == 2 && !_showPatternComplete,
                ),
              ),
            ),
            // Bottom-right circle
            Positioned(
              right: 200,
              bottom: 200,
              child: GestureDetector(
                onTap: () => _handleTap(3),  // Make circles tappable
                child: CircleWidget(
                  isActive: _currentCircle == 3 && !_showPatternComplete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
