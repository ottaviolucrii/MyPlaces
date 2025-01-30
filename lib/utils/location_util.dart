
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


const GOOGLE_API_KEY = 'AIzaSyCMKXBI5oTsXVU7VdIiA8R3SsLEHe6h0Yg';

class LocationUtil {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    if (resData['results'].isEmpty) {
      return 'No address found';
    }
    return resData['results'][0]['formatted_address'];
  }
}