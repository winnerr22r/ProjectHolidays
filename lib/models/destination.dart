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
        'https://th.bing.com/th/id/OIP.DJSM28mJBXHUdv4roTeg2AHaE8?w=269&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://tse3.mm.bing.net/th/id/OIP.ZVmpYeVNdhvae_tR3qiRVgHaE8?r=0&pid=ImgDet&w=184&h=122&c=7&dpr=1,3&o=7&rm=3',
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
        'https://th.bing.com/th/id/OIP.cv90vhZbo8ZnY3MMniKSugHaE8?w=334&h=182&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://th.bing.com/th/id/OIP.sQmmIx-0h3_EqSLHw5T9qwHaE8?w=272&h=181&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://th.bing.com/th/id/OIP.HuzG3cKWbwsZvLY10Yq7lwHaE8?w=280&h=187&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://th.bing.com/th/id/OIP.i6gyDcnx1fpKoLXWroDaIAHaE8?w=215&h=150&c=6&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://th.bing.com/th/id/OIP.RIYZWcAz34ogVsdzc0hpxgHaE7?w=291&h=194&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://th.bing.com/th/id/OIP.YcDmyeW1xfUJ2Xg5bNNgqQHaEK?w=266&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
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
        'https://tse3.mm.bing.net/th/id/OIP.X32GJJCV_T4tzBfDluDF7wHaEK?r=0&w=700&h=393&rs=1&pid=ImgDetMain&o=7&rm=3',
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
        'https://th.bing.com/th/id/OIP.DD1usHdkSJbXYvj0UuFuWwHaEK?w=284&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
  ),
];
