import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'info_routes.g.dart';

class InfoRoutes extends Table {

  TextColumn get id => text().nullable()();
  TextColumn get info => text().nullable()();
  TextColumn get type => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [InfoRoutes])
class InfoRoutesDao extends DatabaseAccessor<AppDatabase>
    with _$InfoRoutesDaoMixin {

  final AppDatabase db;
  InfoRoutesDao(this.db) : super(db);

  Stream<List<InfoRoute>> watchAllInfoRoutes() => select(infoRoutes).watch();
  Future<List<InfoRoute>> getAllInfoRoutes() => select(infoRoutes).get();

  Future<void> insertAllInfoRoutes(List<Insertable<InfoRoute>> rows) => batch((batch) =>
      batch.insertAll(infoRoutes, rows, mode: InsertMode.insertOrReplace));
  Future insertInfoRoutes(Insertable<InfoRoute> row) => into(infoRoutes).insert(row, mode: InsertMode.replace);
  Future updateInfoRoutes(Insertable<InfoRoute> row) => update(infoRoutes).replace(row);
  Future deleteInfoRoutes(Insertable<InfoRoute> row) => delete(infoRoutes).delete(row);

  Future<List<InfoRoute>> getInfoRoutesByType(String mode) {
    return (select(infoRoutes)
      ..where((tbl) => tbl.type.equals(mode))
    ).get();
  }

}
