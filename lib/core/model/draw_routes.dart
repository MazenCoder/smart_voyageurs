import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'draw_routes.g.dart';

class DrawRoutes extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get id_route => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  // @override
  // Set<Column> get primaryKey => {id};
}

@UseDao(tables: [DrawRoutes])
class DrawRoutesDao extends DatabaseAccessor<AppDatabase>
    with _$DrawRoutesDaoMixin {

  final AppDatabase db;
  DrawRoutesDao(this.db) : super(db);

  Stream<List<DrawRoute>> watchAllDrawRoutes() => select(drawRoutes).watch();
  Future<List<DrawRoute>> getAllDrawRoutes() => select(drawRoutes).get();

  Future<void> insertAllDrawRoutes(List<Insertable<DrawRoute>> rows) => batch((batch) =>
      batch.insertAll(drawRoutes, rows, mode: InsertMode.insertOrReplace));
  Future insertDrawRoutes(Insertable<DrawRoute> row) => into(drawRoutes).insert(row, mode: InsertMode.replace);
  Future updateDrawRoutes(Insertable<DrawRoute> row) => update(drawRoutes).replace(row);
  Future deleteDrawRoutes(Insertable<DrawRoute> row) => delete(drawRoutes).delete(row);

  Future<List<DrawRoute>> getRoutesByIdRout(String id_route) {
    return (select(drawRoutes)
      ..where((tbl) => tbl.id_route.equals(id_route))
    ).get();
  }

  Stream<List<DrawRoute>> watchRoutesByIdRout(String id_route) {
    return (select(drawRoutes)
      ..where((tbl) => tbl.id_route.equals(id_route))
    ).watch();
  }
}
