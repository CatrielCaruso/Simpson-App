import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:simpsons_app/core/database/isar.database.dart';

import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final _isadDatabaseServices = GetIt.I<IsarDataBase>();

  List<SimpsonModel> characters = [];
  bool isFavorite = false;

  bool isLoading = false;

  Future<void> initiliazeData() async {
    isLoading = true;

    characters = await _isadDatabaseServices.loadCharacters();

    isLoading = false;
    notifyListeners();
  }

  void onTap(bool isFavorite, int characterId) {
    if (!isFavorite) {
      characters.removeWhere((character) => character.id == characterId);
      notifyListeners();
    }

    return;
  }
}
