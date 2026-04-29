import 'package:flutter/material.dart';
import '../models/destination.dart';

/// Manages the list of favorited destinations across the app.
/// Wrap your MaterialApp with ChangeNotifierProvider<FavoritesProvider>
/// to make this available everywhere.
class FavoritesProvider extends ChangeNotifier {
  final List<Destination> _favorites = [];

  List<Destination> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Destination destination) {
    return _favorites.any(
      (d) => d.destinationName == destination.destinationName,
    );
  }

  /// Adds or removes a destination from favorites and returns the new state.
  bool toggle(Destination destination) {
    if (isFavorite(destination)) {
      _favorites.removeWhere(
        (d) => d.destinationName == destination.destinationName,
      );
      notifyListeners();
      return false; // removed
    } else {
      _favorites.add(destination);
      notifyListeners();
      return true; // added
    }
  }
}
