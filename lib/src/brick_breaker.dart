import 'dart:async';
import 'dart:math' as math;

import 'package:brick_breaker/src/components/components.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';

enum PlayState {
  welcome,
  playing,
  gameOver,
  won,
}

class BrickBreaker extends FlameGame
    with
        HasCollisionDetection,
        KeyboardEvents,
        PointerMoveCallbacks,
        TapDetector {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final m.ValueNotifier<int> score = m.ValueNotifier(0);
  double lastBrickScrollLength = brickHeight;
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    if (playState == PlayState.playing) {
      return;
    }

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.playing;
    score.value = 0;

    world.add(
      Ball(
        difficultyModifier: difficultyModifier,
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
            .normalized()
          ..scale(height / 4),
      ),
    );

    world.add(
      Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const m.Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
      ),
    );
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  @override // Add from here...
  m.KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
      case LogicalKeyboardKey.space: // Add from here...
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return m.KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xff323333);

  @override
  void onPointerMove(PointerMoveEvent event) {
    super.onPointerMove(event);
    if (playState != PlayState.playing) {
      return;
    }
    world.children.query<Bat>().first.move(event.localPosition.x);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (playState != PlayState.playing) {
      return;
    }

    lastBrickScrollLength += scrollSpeed * dt;
    if (lastBrickScrollLength < brickHeight + brickGutter) {
      return;
    }

    lastBrickScrollLength = 0;

    final count = rand.nextInt(3);

    final positions = <int>[];
    while (positions.length < count) {
      final p = rand.nextInt(10);
      if (!positions.contains(p)) {
        positions.add(p);
      }
    }

    world.addAll([
      for (var i = 0; i < positions.length; i++)
        Brick(
          position: Vector2(
            (positions[i] + 0.5) * brickWidth +
                (positions[i] + 1) * brickGutter,
            brickHeight / 2,
          ),
          color: const Color(0xfffe4470),
        ),
    ]);
  }
}
