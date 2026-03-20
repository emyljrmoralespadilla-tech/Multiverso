import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterProvider extends ChangeNotifier {

  List<int> favourites = [];

  CharacterProvider() {
    loadFavourites();
  }

  void toggleFavourite(int id) async {

    if (favourites.contains(id)) {
      favourites.remove(id);
    } else {
      favourites.add(id);
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'favourites',
        favourites.map((e) => e.toString()).toList());

    notifyListeners();
  }

  Future<void> loadFavourites() async {

    final prefs = await SharedPreferences.getInstance();

    final favs = prefs.getStringList('favourites') ?? [];

    favourites = favs.map((e) => int.parse(e)).toList();

    notifyListeners();
  }

  bool isFavourite(int id) {
    return favourites.contains(id);
  }
}