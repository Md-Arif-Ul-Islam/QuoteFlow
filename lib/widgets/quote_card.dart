import 'package:flutter/material.dart';
import '../models/quote.dart';

/// A premium, minimal card widget that displays a [Quote].
class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerLow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative quotes icon
            Icon(
              Icons.format_quote_rounded,
              size: 48,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            
            // Quote text
            Text(
              '"${quote.text}"',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: theme.colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            
            // Subtle horizontal divider line
            Container(
              width: 48,
              height: 2.5,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(1.25),
              ),
            ),
            const SizedBox(height: 20),
            
            // Author name
            Text(
              "— ${quote.author}",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
