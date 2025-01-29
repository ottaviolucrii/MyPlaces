import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop0001/providers/great_places.dart';
import 'package:shop0001/utils/app_routes.dart';


class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: const Text('No places yet!'),
        ),
        builder: (ctx, greatPlaces, child) => greatPlaces.itemsCount == 0
            ? child!
            : ListView.builder(
                itemCount: greatPlaces.itemsCount,
                itemBuilder: (ctx , i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.itemByIndex(i).image),
                  ),
                  title: Text(greatPlaces.itemByIndex(i).name),
                  onTap: (){},
                ),
              ),
      ),
    );
  }
}
