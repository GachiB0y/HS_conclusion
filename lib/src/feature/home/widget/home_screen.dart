import 'package:flutter/material.dart';
import 'package:hs_conclusion/src/feature/conclusion/widget/conclusion_screen.dart';
import 'package:hs_conclusion/src/feature/conclusion/widget/replacement_screen.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabInddex = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: IndexedStack(
            index: _tabInddex,
            children: const [
              ConclusionScreen(),
              ReplacementScren(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tabInddex,
          onDestinationSelected: (int index) {
            setState(() {
              _tabInddex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Ввывод',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt),
              label: 'Замена',
            ),
          ],
        ),
      );
}
