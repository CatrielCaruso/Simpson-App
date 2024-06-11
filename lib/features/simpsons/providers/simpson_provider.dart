import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:simpsons_app/core/services/simpson_services.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class SimpsonProvider extends ChangeNotifier {
  final _simpsonServices = GetIt.I<SimpsonServices>();

  late SimpsonModel simpson;
  List<SimpsonModel> characters = [];
  bool isLoading = false;

  Future<void> getSimponsList() async {
    try {
      if (characters.isNotEmpty) return;
      isLoading = true;

      characters = await _simpsonServices.getSimponsList();

      await addIndexToCaracter();
      isLoading = false;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> addIndexToCaracter() async {
    for (int i = 0; i < characters.length; i++) {
      characters[i].id = i;
    }
  }
}
