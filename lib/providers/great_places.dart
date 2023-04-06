import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_travels/utils/db_util.dart';

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
            location: null,
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  void addPlace(String title, File? image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image!,
    );

    _items.add(newPlace);
    DbUtil.insert(DbUtil.tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    notifyListeners();
  }
}
