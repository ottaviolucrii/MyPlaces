import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shop0001/models/place.dart';
import 'package:shop0001/utils/location_util.dart';
import 'package:shop0001/screens/map_screen.dart';



class LocationInput extends StatefulWidget {
  final Function (LatLng, String)onSelectPosition;
  LocationInput(this.onSelectPosition,{super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      if (locData.latitude != null && locData.longitude != null) {
        final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
          latitude: locData.latitude!,
          longitude: locData.longitude!,
        );

        final address = await LocationUtil.getPlaceAddress(
          locData.latitude!,
          locData.longitude!,
        );

        setState(() {
          _previewImageUrl = staticMapImageUrl;
        });

        widget.onSelectPosition(
          LatLng(locData.latitude!, locData.longitude!),
          address,
        );
      }
    } catch (error) {
      // Handle error
      print('Error getting location: $error');
    }
  }
 
  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push( 
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          initialLocation: PlaceLocation(latitude: -21.4745092, longitude: -46.9985976), // Replace with actual initial location
        ),
      ),
    );
    if (selectedPosition == null) {
      return;
    }

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
          latitude: selectedPosition.latitude,
          longitude: selectedPosition.longitude,
        );

        final address = await LocationUtil.getPlaceAddress(
      selectedPosition.latitude,
      selectedPosition.longitude,
    );

        setState(() {
          _previewImageUrl = staticMapImageUrl;
        });

    widget.onSelectPosition(selectedPosition, address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('No location chosen!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Current location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select on map',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}