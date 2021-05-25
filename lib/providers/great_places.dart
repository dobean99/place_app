import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        img: pickedImage,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_place', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.img.path
    });
  }

  Future<void> fetchAndSetupData() async {
    final dataList = await DBHelper.getData('user_place');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            img: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }
}
