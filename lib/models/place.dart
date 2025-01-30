import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}

class Place {
  final String name;
  final String id;
  final File image;
  final PlaceLocation location;

  Place({
    required this.name,
    required this.id,
    required this.image,
    required this.location,
  });
}
