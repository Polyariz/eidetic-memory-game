import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/tile.dart';
import '../utils/constants.dart';

// Animated flip card widget for the game
class GameCard extends StatefulWidget {
  final Tile tile;
  final VoidCallback onTap;

  const GameCard({
    Key? key,
    required this.tile,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(GameCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tile.isFlipped != oldWidget.tile.isFlipped) {
      if (widget.tile.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tile.isMatched ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * math.pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: angle >= math.pi / 2
                ? Transform(
                    transform: Matrix4.identity()..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return Opacity(
      opacity: widget.tile.isMatched ? 0.0 : 1.0,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: GameConstants.cardFrontColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Opacity(
      opacity: widget.tile.isMatched ? 0.0 : 1.0,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: GameConstants.cardBackColor,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(widget.tile.imagePath),
            fit: BoxFit.contain,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
