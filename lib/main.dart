import 'package:brick_breaker/src/widgets/game_app.dart';
import 'package:brick_breaker/src/widgets/stage_select.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          fontFamily: 'イカモドキ',
          bodyColor: const Color(0xffCD4493),
          displayColor: const Color(0xffCD4493),
        ),
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StageSelect(),
    ),
    GoRoute(
      path: '/game',
      builder: (context, state) => const GameApp(),
    ),
  ],
);
