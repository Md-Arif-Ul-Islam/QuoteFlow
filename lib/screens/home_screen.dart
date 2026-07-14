import 'dart:math';
import 'package:flutter/material.dart';
import '../data/quotes.dart';
import '../widgets/quote_card.dart';
import '../widgets/animated_background.dart';
import 'about_screen.dart';

/// The primary screen displaying the random quotes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Select a random quote immediately on launch
    _currentIndex = _random.nextInt(kQuotes.length);
  }

  /// Selects a different random quote, avoiding consecutive duplicates.
  void _showNewQuote() {
    if (kQuotes.length <= 1) return;

    setState(() {
      // Pick a random offset between 1 and (length - 1),
      // and add it to the current index modulo length.
      // This is mathematically guaranteed to select a different index in O(1).
      final offset = _random.nextInt(kQuotes.length - 1) + 1;
      _currentIndex = (_currentIndex + offset) % kQuotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentQuote = kQuotes[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Quote Generator',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'About',
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AboutScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Animated transition for changing quotes
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.12),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: QuoteCard(
                        // The key forces a fresh transition when index changes
                        key: ValueKey<int>(_currentIndex),
                        quote: currentQuote,
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Center the button horizontally
                    Center(
                      child: FilledButton.icon(
                        onPressed: _showNewQuote,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.auto_awesome_rounded),
                        label: const Text(
                          'New Quote',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
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
      ),
    );
  }
}
