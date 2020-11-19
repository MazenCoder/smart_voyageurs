import 'package:smart_voyageurs/core/model/draw_routes.dart';
import 'package:smart_voyageurs/core/model/info_routes.dart';
import 'package:smart_voyageurs/core/model/users.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

part 'app_database.g.dart';

@UseMoor(
    /// All Tables
    tables: [
      Users,
      DrawRoutes,
      InfoRoutes,
    ],
    /// All Daos
    daos: [
      UsersDao,
      DrawRoutesDao,
      InfoRoutesDao,
    ],
    /// All Queries
    queries: {

    },
)
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.smart',
    logStatements: true,
  )));

  Future<void> deleteAllData() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }

  /*
  (FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.prixpad',
    logStatements: true,
  ))
   */

  @override
  int get schemaVersion => 1;

  //! SINGLETON
  static final AppDatabase _singleton = new AppDatabase._internal();
  AppDatabase._internal() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.smart',
    logStatements: true,
  )));
  /*
  (FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.prixpad',
    logStatements: true,
  ))
   */

  static AppDatabase get instance => _singleton;
}

//LazyDatabase _openConnection() {
//  // the LazyDatabase util lets us find the right location for the file async.
//  return LazyDatabase(() async {
//    final dbFolder = await getApplicationDocumentsDirectory();
//    final file = File(p.join(dbFolder.path, 'db.prixpad'));
//    return VmDatabase(file);
//  });
//}