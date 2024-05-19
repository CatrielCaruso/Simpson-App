import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

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
      isLoading = false;
      notifyListeners();
    } catch (e) {}
  }
}
