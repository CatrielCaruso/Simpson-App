import 'package:get_it/get_it.dart';

import 'package:simpsons_app/core/database/isar.database.dart';
import 'package:simpsons_app/core/services/simpson_services.dart';

final locator = GetIt.I;
void serviceLocatorInit() {
  locator.registerSingleton(SimpsonServices());
  locator.registerSingleton(IsarDataBase());
}
