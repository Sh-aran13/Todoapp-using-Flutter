
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class LoginAnimatedBackground extends StatelessWidget {
  const LoginAnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.grey.shade900,
          ],
        ),
      ),
      child: CircularParticle(
        key: UniqueKey(),
        awayRadius: screenWidth / 10,
        numberOfParticles: 30,
        speedOfParticles: 0.5,
        height: screenHeight,
        width: screenWidth,
        onTapAnimation: false,
        particleColor: Colors.white.withAlpha(50),
        awayAnimationDuration: const Duration(milliseconds: 200),
        maxParticleSize: 1,
        isRandomColor: false,
        awayAnimationCurve: Curves.linear,
        enableHover: false,
        hoverColor: Colors.white,
        hoverRadius: 90,
        connectDots: false,
      ),
    );
  }
}
