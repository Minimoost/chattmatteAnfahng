import 'package:flutter/material.dart';
import '../models/character.dart';

class MoodIndicator extends StatelessWidget {
  final Character character;
  final double size;
  final bool showText;
  final bool animate;
  
  const MoodIndicator({
    super.key,
    required this.character,
    this.size = 24.0,
    this.showText = false,
    this.animate = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: animate ? const Duration(milliseconds: 500) : Duration.zero,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: _buildMoodWidget(context),
    );
  }
  
  Widget _buildMoodWidget(BuildContext context) {
    // Determine emoji and color based on emotional state
    String emoji;
    Color color;
    String moodText;
    
    if (character.isDistant) {
      emoji = '😒';
      color = Colors.red.shade300;
      moodText = 'Distanziert';
    } else if (character.isNeutral) {
      emoji = '😐';
      color = Colors.blue.shade300;
      moodText = 'Neutral';
    } else if (character.isNice) {
      emoji = '🙂';
      color = Colors.green.shade300;
      moodText = 'Nett';
    } else if (character.isInterested) {
      emoji = '😊';
      color = Colors.purple.shade300;
      moodText = 'Interessiert';
    } else {
      // Fallback
      emoji = '😐';
      color = Colors.grey;
      moodText = 'Neutral';
    }
    
    // Create a key based on the mood for the AnimatedSwitcher
    final Key key = ValueKey<String>(emoji);
    
    if (showText) {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: size),
          ),
          const SizedBox(width: 4),
          Text(
            moodText,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.6,
            ),
          ),
        ],
      );
    } else {
      return Text(
        emoji,
        key: key,
        style: TextStyle(fontSize: size),
      );
    }
  }
  
  // Helper method to get color for chat bubbles based on mood
  static Color getChatBubbleColor(Character character) {
    if (character.isDistant) {
      return Colors.grey.shade200;
    } else if (character.isNeutral) {
      return Colors.white;
    } else if (character.isNice) {
      return Colors.green.shade50;
    } else if (character.isInterested) {
      return Colors.purple.shade50;
    } else {
      return Colors.white;
    }
  }
  
  // Helper method to get gradient for background based on mood
  static LinearGradient getBackgroundGradient(Character character) {
    if (character.isDistant) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade100, Colors.grey.shade200],
      );
    } else if (character.isNeutral) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade50, Colors.grey.shade100],
      );
    } else if (character.isNice) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.green.shade50, Colors.blue.shade50],
      );
    } else if (character.isInterested) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple.shade50, Colors.pink.shade50],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade100, Colors.grey.shade100],
      );
    }
  }
}
