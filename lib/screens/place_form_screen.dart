import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/images_input.dart';
import 'dart:io';
import '../widgets/location_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;
  String? _pickedAddress;

  void _selectImage(File pickedImage) {
    setState(() {
          _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position, String address) {
    setState(() {
      _pickedPosition = position;
      _pickedAddress = address;
    });
  }
  bool _isValidForm() {
    return _titleController.text.isNotEmpty && _pickedImage != null && _pickedPosition != null;
  }

  void _submitForm() {
    
      if(!_isValidForm()){
        return;
      }
    
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
      _pickedAddress!,      
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new place',
          style: TextStyle(
            color: Colors.white,
          ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (_){
                        setState((){});
                      }
                    ),
                    SizedBox(height: 10),
                    ImagesInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPosition)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add place'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: _isValidForm() ? _submitForm : null, 
          ),
        ],
      ),
    );
  }
}
