/// Model for user data
class User {
  final String name;
  final String email;
  final String avatar;

  User({
    required this.name,
    required this.email,
    required this.avatar,
  });
}

/// Dummy user data
final User dummyUser = User(
  name: 'Sarah Anderson',
  email: 'sarah.anderson@email.com',
  avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop',
);
