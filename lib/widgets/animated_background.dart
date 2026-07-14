import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that provides a beautiful, premium, shifting mesh gradient background.
class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Continuous smooth animation over 15 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // Solid background base
        Container(
          color: isDark ? const Color(0xFF0A0A14) : const Color(0xFFFAF9FF),
        ),
        
        // Shifting glowing orbs
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _AuraPainter(
                  progress: _controller.value,
                  primaryColor: theme.colorScheme.primary.withValues(alpha: 0.22),
                  secondaryColor: theme.colorScheme.secondary.withValues(alpha: 0.22),
                  tertiaryColor: theme.colorScheme.tertiary.withValues(alpha: 0.18),
                ),
              );
            },
          ),
        ),
        
        // Blur filter to smooth the colors into a mesh gradient
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        
        // Semi-transparent overlay for text legibility
        Positioned.fill(
          child: Container(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.35),
          ),
        ),
        
        // Content overlay
        Positioned.fill(
          child: widget.child,
        ),
      ],
    );
  }
}

/// Custom painter to draw shifting colored orbs.
class _AuraPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  _AuraPainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * math.pi;

    // Orb 1: Primary color moving in a custom loop
    final x1 = size.width * 0.3 + size.width * 0.15 * math.cos(t);
    final y1 = size.height * 0.35 + size.height * 0.12 * math.sin(2 * t);
    _drawOrb(canvas, Offset(x1, y1), size.width * 0.42, primaryColor);

    // Orb 2: Secondary color moving in an offset loop
    final x2 = size.width * 0.7 + size.width * 0.15 * math.sin(t);
    final y2 = size.height * 0.65 + size.height * 0.14 * math.cos(t);
    _drawOrb(canvas, Offset(x2, y2), size.width * 0.48, secondaryColor);

    // Orb 3: Tertiary color drifting in the center
    final x3 = size.width * 0.5 + size.width * 0.18 * math.cos(2 * t + 1);
    final y3 = size.height * 0.45 + size.height * 0.16 * math.sin(t + 0.5);
    _drawOrb(canvas, Offset(x3, y3), size.width * 0.38, tertiaryColor);
  }

  /// Draws an individual radial gradient orb.
  void _drawOrb(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _AuraPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.tertiaryColor != tertiaryColor;
  }
}
