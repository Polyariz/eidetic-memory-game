import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../utils/constants.dart';
import 'game_screen.dart';
import 'how_to_play_screen.dart';

// Home screen with START button
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'EI·DET·IC\nīˈdedik/',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      color: GameConstants.primaryTextColor,
                      shadows: [
                        Shadow(
                          color: const Color(0xFFFFFCFA),
                          offset: const Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Subtitle
                  Text(
                    'A MEMORY GAME',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: GameConstants.secondaryTextColor,
                      shadows: [
                        Shadow(
                          color: const Color(0xFFFFFCFA),
                          offset: const Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // START button
                  ElevatedButton(
                    onPressed: () {
                      final gameState =
                          Provider.of<GameState>(context, listen: false);
                      gameState.initializeGame();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GameConstants.buttonColor,
                      foregroundColor: GameConstants.buttonTextColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'START GAME',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // How to Play link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HowToPlayScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GameConstants.buttonHoverColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'How to Play',
                        style: TextStyle(
                          fontSize: 20,
                          color: GameConstants.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Footer
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Images by Helen Frankenthaler',
                style: TextStyle(
                  fontSize: 16,
                  color: GameConstants.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
