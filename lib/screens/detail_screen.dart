import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/destination.dart';
import '../screens/favorites_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

/// Detail screen for a specific destination
class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoadingBooking = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDuration.verySlow,
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite(BuildContext context) {
    final provider = context.read<FavoritesProvider>();
    final added = provider.toggle(widget.destination);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              added ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(added ? 'Added to favorites' : 'Removed from favorites'),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: added ? Colors.red : AppColors.primary,
      ),
    );
  }

  /// Opens Booking.com search page for this destination
  Future<void> _openBookingCom() async {
    setState(() => _isLoadingBooking = true);

    try {
      final destinationQuery = Uri.encodeComponent(
        widget.destination.destinationName,
      );

      final now = DateTime.now();
      final checkIn = now.add(const Duration(days: 1));
      final checkOut = now.add(const Duration(days: 2));

      final bookingUrl = Uri.parse(
        'https://www.booking.com/search.html'
        '?ss=$destinationQuery'
        '&checkin=${checkIn.year}-${_pad(checkIn.month)}-${_pad(checkIn.day)}'
        '&checkout=${checkOut.year}-${_pad(checkOut.month)}-${_pad(checkOut.day)}'
        '&group_adults=2'
        '&no_rooms=1'
        '&aid=304142',
      );

      if (await canLaunchUrl(bookingUrl)) {
        await launchUrl(bookingUrl, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) _showBookingError();
      }
    } catch (e) {
      if (mounted) _showBookingError();
    } finally {
      if (mounted) setState(() => _isLoadingBooking = false);
    }
  }

  String _pad(int number) => number.toString().padLeft(2, '0');

  void _showBookingError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open Booking.com. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch favorite state so icon re-renders on toggle
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(
      widget.destination,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            leading: Container(
              margin: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
            actions: [
              // Favorite button — reads from FavoritesProvider
              Container(
                margin: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _toggleFavorite(context),
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey(isFavorite),
                          color: isFavorite
                              ? Colors.red
                              : AppColors.textPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.destination.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.textTertiary,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.destination.destinationName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          widget.destination.location,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.accent,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            widget.destination.rating.toString(),
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          const Text(
                            '(4.2k reviews)',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Text(
                      'About',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      widget.destination.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const Text(
                      'Amenities',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _AmenityItem(icon: Icons.hotel, label: 'Hotels'),
                        _AmenityItem(
                          icon: Icons.restaurant,
                          label: 'Restaurants',
                        ),
                        _AmenityItem(
                          icon: Icons.directions_car,
                          label: 'Transport',
                        ),
                        _AmenityItem(
                          icon: Icons.shopping_bag,
                          label: 'Shopping',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    // Booking.com banner
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFF003580),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.hotel_class,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Find hotels on Booking.com',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Best prices guaranteed',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB700),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: const Text(
                              'PARTNER',
                              style: TextStyle(
                                color: Color(0xFF003580),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _isLoadingBooking
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : PrimaryButton(
                            label: 'Book Now on Booking.com',
                            onPressed: _openBookingCom,
                          ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
