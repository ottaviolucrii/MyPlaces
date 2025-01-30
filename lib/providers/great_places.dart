import 'package:flutter/foundation.dart';
import 'package:shop0001/models/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shop0001/utils/db_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('user_places');
    _items = dataList.map((item) {
      return Place(
        id: item['id'],
        name: item['title'],
        image: File(item['image']),
        location: PlaceLocation(
          latitude: item['latitude'],
          longitude: item['longitude'],
          address: item['address'],
        ),
      );
    }).toList();
    notifyListeners();
  }

  Future<void> addPlace(
      String name, File image, LatLng position, String address) async {
    final newPlace = Place(
      name: name,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
      id: Random().nextDouble().toString(),
    );

    _items.add(newPlace);
    DbUtil.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
      
    });
    notifyListeners();
  }
}
