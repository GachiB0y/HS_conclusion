import 'package:flutter/material.dart';
import 'package:hs_conclusion/src/feature/conclusion/widget/conclusion_screen.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const SafeArea(child: ConclusionScreen()),
      );
}
