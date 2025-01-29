import 'package:flutter/foundation.dart';
import 'package:shop0001/models/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shop0001/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index){
    return _items[index];
  }

  void addPlace(String name, File image){
    final newPlace = Place(
      name: name,
      image: image,
      location: PlaceLocation(latitude: 0.0, longitude: 0.0, address: ''),
      id: Random().nextDouble().toString(),
    );

    _items.add(newPlace);
    DbUtil.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path,
    });
    notifyListeners();
  }
}