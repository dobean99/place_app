import 'dart:math';

import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List _items = [];

  List<Place> get items {
    return [..._items];
  }
  void addPlace(String title,File pickedImage)
  {
    final newPlace= Place(id: DateTime.now().toString(),title: title,img: pickedImage,location: null);
    _items.add(newPlace);
    notifyListeners();
  }
}
