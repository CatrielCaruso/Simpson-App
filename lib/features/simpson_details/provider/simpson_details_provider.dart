import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:simpsons_app/core/database/isar.database.dart';
import 'package:translator/translator.dart';

import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class SimpsonDetailsProvider extends ChangeNotifier {
  final _isadDatabaseServices = GetIt.I<IsarDataBase>();
  late SimpsonModel simpson;
  List<SimpsonModel> characters = [];
  bool isFavorite = false;

  bool isLoading = false;

  Future<void> initiliazeData({required SimpsonModel character}) async {
    isLoading = true;

    simpson = character;
    await isCharacterFavorite(characterId: character.isarId);
    await traductQuote();

    isLoading = false;
    notifyListeners();
  }

  Future<void> traductQuote() async {
    final translator = GoogleTranslator();
    Translation? translatorResult;
    try {
      translatorResult = await translator.translate(simpson.quote, to: 'es');
      simpson.quoteTranslatedIntoSpanish = translatorResult.text;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(
      {required SimpsonModel character, Function? onTap}) async {
    await _isadDatabaseServices.toggleFavorite(character: character);
    await isCharacterFavorite(characterId: character.isarId);
    if (onTap != null) {
      onTap(simpson.isFavorite, character.id);
    }
  }

  Future<void> isCharacterFavorite({int? characterId}) async {
    bool isFavorite = await _isadDatabaseServices.isCharacterFavorite(
        characterId: characterId);
    simpson.isFavorite = isFavorite;
    notifyListeners();
  }
}
