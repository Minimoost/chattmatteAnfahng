import 'package:flutter/material.dart';
import '../models/character.dart';

class MoodBar extends StatelessWidget {
  final Character character;
  final double height;
  final bool animate;
  
  const MoodBar({
    super.key,
    required this.character,
    this.height = 4.0,
    this.animate = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate position based on emotional state (-100 to 100)
          // Map to 0.0 to 1.0 for the width percentage
          final double normalizedValue = (character.emotionalState + 100) / 200;
          final double position = constraints.maxWidth * normalizedValue;
          
          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade300,
                      Colors.grey.shade300,
                      Colors.blue.shade300,
                      Colors.green.shade300,
                      Colors.purple.shade300,
                    ],
                    stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                ),
              ),
              
              // Indicator
              Positioned(
                left: position - 4,
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: animate ? const Duration(milliseconds: 500) : Duration.zero,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
