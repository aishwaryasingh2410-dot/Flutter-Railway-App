import 'package:flutter/material.dart';

/// Sketch-style Mumbai skyline + platform + local (reference UI).
class LoginHeroHeader extends StatelessWidget {
  const LoginHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFB3E5FC),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _SkylinePainter()),
          Positioned(
            left: 16,
            top: 20,
            child: Text(
              'Mumbai India',
              style: TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade900,
                shadows: const [
                  Shadow(color: Colors.white24, blurRadius: 2, offset: Offset(1, 1)),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 56,
            child: ColoredBox(
              color: Colors.grey.shade400,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Text(
                      'मुंबई',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.train, size: 42, color: Colors.blueGrey.shade800),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sky = Paint()..color = const Color(0xFF81D4FA);
    canvas.drawRect(Offset.zero & size, sky);

    final b = Paint()..color = Colors.blueGrey.shade700;
    final buildings = <Rect>[
      Rect.fromLTWH(size.width * 0.05, size.height * 0.35, 28, size.height * 0.45),
      Rect.fromLTWH(size.width * 0.12, size.height * 0.28, 22, size.height * 0.52),
      Rect.fromLTWH(size.width * 0.18, size.height * 0.4, 36, size.height * 0.4),
      Rect.fromLTWH(size.width * 0.28, size.height * 0.22, 30, size.height * 0.58),
      Rect.fromLTWH(size.width * 0.36, size.height * 0.32, 24, size.height * 0.48),
      Rect.fromLTWH(size.width * 0.44, size.height * 0.26, 40, size.height * 0.54),
      Rect.fromLTWH(size.width * 0.55, size.height * 0.38, 26, size.height * 0.42),
      Rect.fromLTWH(size.width * 0.62, size.height * 0.3, 32, size.height * 0.5),
      Rect.fromLTWH(size.width * 0.72, size.height * 0.34, 28, size.height * 0.46),
      Rect.fromLTWH(size.width * 0.8, size.height * 0.4, 34, size.height * 0.4),
    ];
    for (final r in buildings) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(2)),
        b,
      );
    }

    final cloud = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawOval(Rect.fromLTWH(size.width * 0.5, 24, 70, 28), cloud);
    canvas.drawOval(Rect.fromLTWH(size.width * 0.62, 20, 55, 24), cloud);

    final plane = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(Offset(size.width * 0.15, 36), Offset(size.width * 0.28, 30), plane);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
