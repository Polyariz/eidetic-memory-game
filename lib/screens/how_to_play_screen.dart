import 'package:flutter/material.dart';
import '../utils/constants.dart';

// How to Play instructions screen
class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: GameConstants.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: GameConstants.buttonColor),
        title: const Text(
          'How to Play',
          style: TextStyle(
            color: GameConstants.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'EI·DET·IC\nīˈdedik/',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
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
              const SizedBox(height: 10),
              // Subtitle
              Text(
                'A MEMORY GAME',
                style: TextStyle(
                  fontSize: 20,
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
              const SizedBox(height: 30),
              // Instructions
              const Text(
                'How to play',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: GameConstants.buttonColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildInstructionText(
                'This is a simple matching memory game with an added word recall challenge.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'Visuospatial processing diminishes with age and the loss of this skill is a major component of cognitive decline.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'Eidetic memory is the ability to recall information from memory after only a few moments of exposure without using an mnemonic device.',
                isBold: true,
              ),
              const SizedBox(height: 10),
              _buildInstructionText(
                'Perhaps training this "memory" can help ward off the loss of visuospatial processing we experience with aging.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'This game will test the player\'s ability to recall a word after the matching game.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'Upon starting the game, the screen will display a word for a few seconds.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'Then the word will disappear, replaced with game board of 16 tiles.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'When clicked the tile will flip, displaying a character. The player will select a second tile.\nIf the tiles are a match, they will disappear from play.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'If they are not a match, the tiles will flip back over.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'The player must match all eight pairs of characters.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'Once all pairs are matched, the player will be asked to recall the initial word.',
              ),
              const SizedBox(height: 15),
              _buildInstructionText(
                'The player must select the word that appeared initially in order to "win" the round.',
              ),
              const SizedBox(height: 30),
              // Back button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GameConstants.buttonColor,
                  foregroundColor: GameConstants.buttonTextColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Back to Game',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionText(String text, {bool isBold = false}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: GameConstants.buttonColor,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
