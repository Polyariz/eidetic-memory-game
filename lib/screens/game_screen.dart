import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../utils/constants.dart';
import '../widgets/game_card.dart';
import '../widgets/memory_word_dialog.dart';
import '../widgets/recall_dialog.dart';
import '../widgets/congrats_dialog.dart';
import '../widgets/try_again_dialog.dart';
import 'how_to_play_screen.dart';

// Main game screen with card grid and game logic
class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _hasShownMemoryWord = false;

  @override
  void initState() {
    super.initState();
    // Show memory word dialog after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMemoryWordDialog();
    });
  }

  void _showMemoryWordDialog() {
    final gameState = Provider.of<GameState>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: GameConstants.modalOverlayColor,
      builder: (context) => MemoryWordDialog(word: gameState.memoryWord),
    );

    // Auto-dismiss after delay
    Future.delayed(
        const Duration(milliseconds: GameConstants.wordDisplayMilliseconds),
        () {
      if (mounted) {
        Navigator.of(context).pop();
        _hasShownMemoryWord = true;
      }
    });
  }

  void _showRecallDialog() {
    final gameState = Provider.of<GameState>(context, listen: false);
    final words = gameState.getRecallWords();

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: GameConstants.modalOverlayColor,
      builder: (context) => RecallDialog(
        words: words,
        correctWord: gameState.memoryWord,
        onCorrect: () {
          _showCongratsDialog();
        },
        onIncorrect: () {
          _showTryAgainDialog();
        },
      ),
    );
  }

  void _showCongratsDialog() {
    final gameState = Provider.of<GameState>(context, listen: false);
    // Add bonus point for correct recall
    gameState.score++;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: GameConstants.modalOverlayColor,
      builder: (context) => CongratsDialog(
        score: gameState.score,
        guesses: gameState.guesses,
        onPlayAgain: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: GameConstants.modalOverlayColor,
      builder: (context) => TryAgainDialog(
        onTryAgain: () {
          _showRecallDialog();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.backgroundColor,
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            // Check if all matched and show recall dialog
            if (gameState.allMatched && _hasShownMemoryWord) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  _hasShownMemoryWord = false; // Reset for next game
                  _showRecallDialog();
                }
              });
            }

            return Column(
              children: [
                // Scoreboard
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              horizontal: 10, vertical: 5),
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
                              fontSize: 16,
                              color: GameConstants.buttonColor,
                            ),
                          ),
                        ),
                      ),
                      // Score
                      Text(
                        'Points: ${gameState.score}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: GameConstants.secondaryTextColor,
                          shadows: [
                            Shadow(
                              color: const Color(0xFFFFFCFA),
                              offset: const Offset(1, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      // Guesses
                      Text(
                        'Guesses: ${gameState.guesses}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: GameConstants.secondaryTextColor,
                          shadows: [
                            Shadow(
                              color: const Color(0xFFFFFCFA),
                              offset: const Offset(1, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Game grid
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: GameConstants.gridBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(5),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: gameState.tiles.length,
                      itemBuilder: (context, index) {
                        return GameCard(
                          tile: gameState.tiles[index],
                          onTap: () => gameState.selectCard(index),
                        );
                      },
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
