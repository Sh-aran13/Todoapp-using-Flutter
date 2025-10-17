import 'dart:math';
import 'package:flutter/material.dart';

class HomeAnimatedBackground extends StatefulWidget {
  const HomeAnimatedBackground({super.key});

  @override
  State<HomeAnimatedBackground> createState() => _HomeAnimatedBackgroundState();
}

class _HomeAnimatedBackgroundState extends State<HomeAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Star>? _stars;
  final int _starCount = 400;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // This duration is arbitrary for a continuous loop
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the guaranteed constraints from LayoutBuilder to initialize stars.
        if (_stars == null && constraints.maxWidth != 0) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          _stars = List.generate(_starCount, (index) => Star.random(size));
        }

        // While stars are initializing (on the very first frame), show a black container.
        if (_stars == null) {
          return Container(color: Colors.black);
        }

        // Once ready, build the animation.
        return Container(
          color: Colors.black,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: StarfieldPainter(_stars!),
              );
            },
          ),
        );
      },
    );
  }
}

class Star {
  double x, y, z;

  Star(this.x, this.y, this.z);

  factory Star.random(Size size) {
    final random = Random();
    return Star(
      (random.nextDouble() * size.width) - size.width / 2,
      (random.nextDouble() * size.height) - size.height / 2,
      random.nextDouble() * size.width,
    );
  }

  void update(Size size) {
    z = z - 3;
    if (z < 1) {
      if (size.isEmpty) return;
      final random = Random();
      x = (random.nextDouble() * size.width) - size.width / 2;
      y = (random.nextDouble() * size.height) - size.height / 2;
      z = size.width;
    }
  }
}

class StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final Paint starPaint;

  StarfieldPainter(this.stars)
      : starPaint = Paint()
          ..color = Colors.white
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (var star in stars) {
      star.update(size);

      if (star.z <= 0) continue;

      final sx = (star.x / star.z) * centerX + centerX;
      final sy = (star.y / star.z) * centerY + centerY;

      if (sx < 0 || sx > size.width || sy < 0 || sy > size.height) {
        continue;
      }

      final pz = star.z + 3;
      if (pz <= 0) continue;

      final px = (star.x / pz) * centerX + centerX;
      final py = (star.y / pz) * centerY + centerY;

      final radius = (1 - star.z / size.width) * 2;
      starPaint.strokeWidth = radius > 0 ? radius : 0;

      if (starPaint.strokeWidth > 0) {
        canvas.drawLine(Offset(px, py), Offset(sx, sy), starPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
