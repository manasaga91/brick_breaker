import 'package:brick_breaker/src/isometric_game/config.dart';
import 'package:brick_breaker/src/isometric_game/isometric_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class IsometricGamePage extends StatelessWidget {
  const IsometricGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FittedBox(
          child: SizedBox(
            width: Config.gameWidth,
            height: Config.gameHeight,
            child: GameWidget(
              game: IsometricGame(),
            ),
          ),
        ),
      ),
    );
  }
}
