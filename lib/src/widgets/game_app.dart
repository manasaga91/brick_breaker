import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:brick_breaker/src/widgets/overlay_screen.dart';
import 'package:brick_breaker/src/widgets/score_card.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff202121),
              Color(0xff323333),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  ScoreCard(score: game.score),
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'タップしてプレイ',
                                  subtitle: 'やじるしキーまたはスワイプ',
                                ),
                            PlayState.gameOver.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'ゲームオーバー',
                                  subtitle: 'タップしてプレイ',
                                ),
                            PlayState.won.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'ノックアウト！！',
                                  subtitle: 'タップしてプレイ',
                                ),
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
