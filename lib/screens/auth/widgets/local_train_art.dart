import 'package:flutter/material.dart';

/// Simple WR-style local train graphic (no external assets).
class LocalTrainArt extends StatelessWidget {
  const LocalTrainArt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Body
          Positioned(
            left: 20,
            right: 20,
            top: 40,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple.shade800, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 18,
                    height: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.purple.shade700),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 10,
                    child: Row(
                      children: List.generate(
                        5,
                        (_) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            width: 14,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade100,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Yellow nose
          Positioned(
            right: 8,
            top: 52,
            child: Container(
              width: 36,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.amber.shade600,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10),
                ),
                border: Border.all(color: Colors.orange.shade800, width: 2),
              ),
            ),
          ),
          // Wheels
          Positioned(
            bottom: 28,
            left: 48,
            child: Row(
              children: List.generate(
                4,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
