import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:simpsons_app/core/services/simpson_services.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class SimpsonProvider extends ChangeNotifier {
  final _simpsonServices = GetIt.I<SimpsonServices>();

  late SimpsonModel simpson;
  List<SimpsonModel> characters = [];
  FocusNode focusNode = FocusNode();
  String searchText = '';
  bool initialLoading = true;

  List<SimpsonModel> searchSimpsons = [];
  bool isLoading = false;

  Future<void> getSimponsList() async {
    try {
      if (characters.isNotEmpty) return;
      isLoading = true;

      characters = await _simpsonServices.getSimponsList();
      searchSimpsons = [...characters];

      await addIndexToCaracter();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addIndexToCaracter() async {
    for (int i = 0; i < characters.length; i++) {
      characters[i].id = i;
    }
  }

  void onSearchClient(String text) {
    searchText = text;

    if (searchText.isEmpty) {
      searchSimpsons.clear();
      searchSimpsons = [...characters];
      notifyListeners();
      return;
    }

    searchSimpsons = characters
        .where((element) => element.character
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
