import 'package:flutter/foundation.dart';
import 'package:shop0001/models/place.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index){
    return _items[index];
  }
}