import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'users.g.dart';

class Users extends Table {

  // IntColumn get id_user => integer().autoIncrement()();
  TextColumn get email => text().nullable()();
  TextColumn get password => text().nullable()();
  BoolColumn get remember_me => boolean().withDefault(Constant(false)).nullable()();

  @override
  Set<Column> get primaryKey => {email};
}

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase>
    with _$UsersDaoMixin {

  final AppDatabase db;
  UsersDao(this.db) : super(db);

  Stream<List<User>> watchAllUsers() => select(users).watch();
  Future<List<User>> getAllUsers() => select(users).get();

  Future<void> insertAllUsers(List<Insertable<User>> rows) => batch((batch) =>
      batch.insertAll(users, rows, mode: InsertMode.insertOrReplace));
  Future insertUsers(Insertable<User> row) => into(users).insert(row, mode: InsertMode.replace);
  Future updateUsers(Insertable<User> row) => update(users).replace(row);
  Future deleteUsers(Insertable<User> row) => delete(users).delete(row);

  Future<User> getUsersByEmail(String email) {
    return (select(users)
      ..where((tbl) => tbl.email.equals(email))
    ).getSingle();
  }

  Future<User> getUsersByNameAndPass({String email, String password}) {
    return (select(users)
      ..where((tbl) => tbl.email.equals(email) & tbl.password.equals(password))
    ).getSingle();
  }

  Future<void> updateProductSend({String email, String password, bool rem}) {
    return (update(users)
      ..where((tbl) => tbl.email.equals(email) & tbl.password.equals(password))
    ).write(User(remember_me: rem));
  }
}
