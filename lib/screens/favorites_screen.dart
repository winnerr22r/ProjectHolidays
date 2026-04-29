import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './favorites_provider.dart';
import '../utils/constants.dart';
import '../widgets/destination_card.dart';

/// Favorites screen — shows destinations saved via the heart icon
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (favorites.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Text(
                    '${favorites.length} saved',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: favorites.isEmpty ? _buildEmpty() : _buildGrid(context, favorites),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) =>
                Transform.scale(scale: value, child: child),
            child: Icon(
              Icons.favorite_border,
              size: 72,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'No favorites yet',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Tap the ♡ on any destination to save it here',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, favorites) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.85,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final destination = favorites[index];
                return DestinationCard(
                  destination: destination,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed('/detail', arguments: destination);
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
