import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class IsarDataBase {
  late Future<Isar> db;

  IsarDataBase() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([SimpsonModelSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  Future<bool> isCharacterFavorite({int? characterId}) async {
    final isar = await db;

    final SimpsonModel? isSimpsonFavorite = await isar.simpsonModels
        .filter()
        .isarIdEqualTo(characterId)
        .findFirst();
    return isSimpsonFavorite != null;
  }

  Future<void> toggleFavorite({required SimpsonModel character}) async {
    final isar = await db;

    final favoriteCharacter = await isar.simpsonModels
        .filter()
        .isarIdEqualTo(character.isarId)
        .findFirst();

    if (favoriteCharacter != null) {
      /// Delete
      isar.writeTxnSync(
          () => isar.simpsonModels.deleteSync(favoriteCharacter.isarId!));
      return;
    }

    /// insert
    isar.writeTxnSync(() => isar.simpsonModels.putSync(character));
  }

  Future<List<SimpsonModel>> loadCharacters() async {
    final isar = await db;

    return isar.simpsonModels.where().findAll();
  }
}
