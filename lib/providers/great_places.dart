import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_travels/utils/db_util.dart';
import 'package:my_travels/utils/location_util.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData(DbUtil.tableName);

    _items = dataList
        .map(
          (place) => Place(
            id: place['id'] as String,
            title: place['title'] as String,
            image: File(place['image'] as String),
            location: PlaceLocation(
              latitude: place['latitude'] as double,
              longitude: place['longitude'] as double,
              address: place['address'] as String,
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  Future<void> addPlace(
    String title,
    File? image,
    LatLng position,
  ) async {
    final String address = await LocationUtil.getAdressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image!,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert(DbUtil.tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
