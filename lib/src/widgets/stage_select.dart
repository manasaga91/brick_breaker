import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StageSelect extends StatelessWidget {
  const StageSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.push('/game'),
          child: const Text('game'),
        ),
      ),
    );
  }
}
