import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StageSelect extends StatelessWidget {
  const StageSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () => context.push('/game'),
              child: const Text('Brick Breaker'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push('/isometric'),
              child: const Text('Isometric'),
            ),
          ],
        ),
      ),
    );
  }
}
