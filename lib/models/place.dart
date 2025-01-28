import 'package:flutter/material.dart';
import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String name;
  final String description;
  final File image;
  final PlaceLocation location;

  Place({
    required this.name,
    required this.description,
    required this.image,
    required this.location,
  });
}
