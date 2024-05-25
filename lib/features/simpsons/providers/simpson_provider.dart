import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:translator/translator.dart';

import 'package:simpsons_app/core/services/simpson_services.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class SimpsonProvider extends ChangeNotifier {
  final simpsonServices = GetIt.I<SimpsonServices>();
  List<SimpsonModel> characters = [];

  bool isLoading = false;

  Future<void> getSimponsList() async {
    try {
      isLoading = true;

      characters = await simpsonServices.getSimponsList();
      await traductQuote();
      await addIndexToCaracter();
      isLoading = false;
      notifyListeners();
    } catch (e) {}
  }

  // Future<void> traductQuote({required SimpsonModel character}) async {
  //   final translator = GoogleTranslator();
  //   try {
  //     isLoading = true;
  //     Translation translatorResult =
  //         await translator.translate(character.quote, to: 'es');
  //     character.quoteTranslatedIntoSpanish = translatorResult.text;
  //     selectedCaracter = character;
  //     isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> traductQuote() async {
    final translator = GoogleTranslator();
    Translation? translatorResult;
    try {
      for (SimpsonModel character in characters) {
        translatorResult =
            await translator.translate(character.quote, to: 'es');
        character.quoteTranslatedIntoSpanish = translatorResult.text;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addIndexToCaracter() async {
    for (int i = 0; i < characters.length; i++) {
      characters[i].index = i;
    }
  }
}
