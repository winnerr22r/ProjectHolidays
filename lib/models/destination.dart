/// Model for tourist destinations
class Destination {
  final int id;
  final String cityName;
  final String tagline;
  final String destinationName;
  final String description;
  final double rating;
  final String location;
  final String imageUrl;

  Destination({
    required this.id,
    required this.cityName,
    required this.tagline,
    required this.destinationName,
    required this.description,
    required this.rating,
    required this.location,
    required this.imageUrl,
  });
}

/// Dummy destination data
final List<Destination> destinations = [
  Destination(
    id: 1,
    cityName: 'Manado',
    tagline: 'Explore Bunaken Paradise',
    destinationName: 'Bunaken National Park',
    description:
        'Bunaken National Park is one of the most beautiful underwater parks in the world. With crystal clear waters and a diverse marine ecosystem, it\'s a paradise for snorkeling and diving enthusiasts.',
    rating: 4.8,
    location: 'Manado, North Sulawesi',
    imageUrl:
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 2,
    cityName: 'Papua',
    tagline: 'Discover Raja Ampat Beauty',
    destinationName: 'Raja Ampat',
    description:
        'Raja Ampat is an archipelago comprising over 1,500 small islands. Known as the heart of the Coral Triangle, it\'s the most biodiverse marine region on Earth with stunning coral reefs.',
    rating: 4.9,
    location: 'Raja Ampat, West Papua',
    imageUrl:
        'https://images.unsplash.com/photo-1549144611-11cffcc6ad32?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 3,
    cityName: 'Bali',
    tagline: 'Spiritual Beauty Awaits',
    destinationName: 'Tanah Lot',
    description:
        'Tanah Lot is an iconic sea temple perched on a dramatic rocky outcrop surrounded by crashing waves. It\'s one of the most picturesque temples in Bali with breathtaking sunset views.',
    rating: 4.7,
    location: 'Tabanan Regency, Bali',
    imageUrl:
        'https://images.unsplash.com/photo-1537225228614-b4fad34a2b08?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 4,
    cityName: 'Yogyakarta',
    tagline: 'Ancient Wonders Unveil',
    destinationName: 'Borobudur',
    description:
        'Borobudur is the largest Buddhist monument in the world, featuring intricate stone carvings and Buddha statues. Visit at sunrise to experience its spiritual majesty with views over the mist-covered valleys.',
    rating: 4.8,
    location: 'Magelang, Central Java',
    imageUrl:
        'https://images.unsplash.com/photo-1573186408919-1f8c9f8b7c8c?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 5,
    cityName: 'Jakarta',
    tagline: 'Modern Meets Heritage',
    destinationName: 'Monas',
    description:
        'The National Monument stands as a symbol of Indonesian independence. Its iconic marble tower offers panoramic views of Jakarta from the observation deck and showcases the nation\'s history.',
    rating: 4.5,
    location: 'Central Jakarta, Indonesia',
    imageUrl:
        'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 6,
    cityName: 'Bandung',
    tagline: 'Crater Lakes Adventure',
    destinationName: 'Kawah Putih',
    description:
        'Kawah Putih is a stunning crater lake famous for its brilliant turquoise and white colors. The lake is surrounded by lush vegetation and offers a unique sulfuric smell due to volcanic activity.',
    rating: 4.6,
    location: 'Bandung, West Java',
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 7,
    cityName: 'Surabaya',
    tagline: 'Colonial Heritage Journey',
    destinationName: 'House of Sampoerna',
    description:
        'The House of Sampoerna is a beautifully preserved Dutch-colonial mansion that showcases the architectural style and cultural heritage of Surabaya during the colonial period.',
    rating: 4.5,
    location: 'Surabaya, East Java',
    imageUrl:
        'https://images.unsplash.com/photo-1490228768704-5466d40c6d9f?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 8,
    cityName: 'Lombok',
    tagline: 'Island Paradise Escape',
    destinationName: 'Gili Trawangan',
    description:
        'Gili Trawangan is a picturesque island paradise known for its white sandy beaches, crystal-clear waters, and vibrant marine life. Perfect for swimming, snorkeling, and relaxing on pristine shores.',
    rating: 4.7,
    location: 'Gili Trawangan, Lombok',
    imageUrl:
        'https://images.unsplash.com/photo-1511316695145-4992006ffddb?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 9,
    cityName: 'Makassar',
    tagline: 'Sunset Harbor Beauty',
    destinationName: 'Pantai Losari',
    description:
        'Pantai Losari is a famous beach known for its stunning sunsets and long, sandy coastline. The beach is lined with restaurants and cafes offering local cuisine and traditional seafood.',
    rating: 4.6,
    location: 'Makassar, South Sulawesi',
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&h=500&fit=crop',
  ),
  Destination(
    id: 10,
    cityName: 'Labuan Bajo',
    tagline: 'Dragons and Islands',
    destinationName: 'Komodo Island',
    description:
        'Komodo Island is home to the legendary Komodo dragons, the world\'s largest living reptiles. The island offers unique trekking experiences through dramatic landscapes and encounters with these magnificent creatures.',
    rating: 4.8,
    location: 'Labuan Bajo, East Nusa Tenggara',
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=500&fit=crop',
  ),
];
