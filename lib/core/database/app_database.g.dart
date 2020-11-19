// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String email;
  final String password;
  final bool remember_me;
  User({this.email, this.password, this.remember_me});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return User(
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      remember_me: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}remember_me']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || remember_me != null) {
      map['remember_me'] = Variable<bool>(remember_me);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      remember_me: remember_me == null && nullToAbsent
          ? const Value.absent()
          : Value(remember_me),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      remember_me: serializer.fromJson<bool>(json['remember_me']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'remember_me': serializer.toJson<bool>(remember_me),
    };
  }

  User copyWith({String email, String password, bool remember_me}) => User(
        email: email ?? this.email,
        password: password ?? this.password,
        remember_me: remember_me ?? this.remember_me,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('remember_me: $remember_me')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(email.hashCode, $mrjc(password.hashCode, remember_me.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.email == this.email &&
          other.password == this.password &&
          other.remember_me == this.remember_me);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> email;
  final Value<String> password;
  final Value<bool> remember_me;
  const UsersCompanion({
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.remember_me = const Value.absent(),
  });
  UsersCompanion.insert({
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.remember_me = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<String> email,
    Expression<String> password,
    Expression<bool> remember_me,
  }) {
    return RawValuesInsertable({
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (remember_me != null) 'remember_me': remember_me,
    });
  }

  UsersCompanion copyWith(
      {Value<String> email, Value<String> password, Value<bool> remember_me}) {
    return UsersCompanion(
      email: email ?? this.email,
      password: password ?? this.password,
      remember_me: remember_me ?? this.remember_me,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (remember_me.present) {
      map['remember_me'] = Variable<bool>(remember_me.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('remember_me: $remember_me')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      true,
    );
  }

  final VerificationMeta _remember_meMeta =
      const VerificationMeta('remember_me');
  GeneratedBoolColumn _remember_me;
  @override
  GeneratedBoolColumn get remember_me =>
      _remember_me ??= _constructRememberMe();
  GeneratedBoolColumn _constructRememberMe() {
    return GeneratedBoolColumn('remember_me', $tableName, true,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [email, password, remember_me];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    }
    if (data.containsKey('remember_me')) {
      context.handle(
          _remember_meMeta,
          remember_me.isAcceptableOrUnknown(
              data['remember_me'], _remember_meMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class DrawRoute extends DataClass implements Insertable<DrawRoute> {
  final int id;
  final String id_route;
  final double latitude;
  final double longitude;
  DrawRoute({@required this.id, this.id_route, this.latitude, this.longitude});
  factory DrawRoute.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return DrawRoute(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      id_route: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_route']),
      latitude: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      longitude: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || id_route != null) {
      map['id_route'] = Variable<String>(id_route);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    return map;
  }

  DrawRoutesCompanion toCompanion(bool nullToAbsent) {
    return DrawRoutesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      id_route: id_route == null && nullToAbsent
          ? const Value.absent()
          : Value(id_route),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
    );
  }

  factory DrawRoute.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DrawRoute(
      id: serializer.fromJson<int>(json['id']),
      id_route: serializer.fromJson<String>(json['id_route']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'id_route': serializer.toJson<String>(id_route),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
    };
  }

  DrawRoute copyWith(
          {int id, String id_route, double latitude, double longitude}) =>
      DrawRoute(
        id: id ?? this.id,
        id_route: id_route ?? this.id_route,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  @override
  String toString() {
    return (StringBuffer('DrawRoute(')
          ..write('id: $id, ')
          ..write('id_route: $id_route, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(id_route.hashCode, $mrjc(latitude.hashCode, longitude.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DrawRoute &&
          other.id == this.id &&
          other.id_route == this.id_route &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class DrawRoutesCompanion extends UpdateCompanion<DrawRoute> {
  final Value<int> id;
  final Value<String> id_route;
  final Value<double> latitude;
  final Value<double> longitude;
  const DrawRoutesCompanion({
    this.id = const Value.absent(),
    this.id_route = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  DrawRoutesCompanion.insert({
    this.id = const Value.absent(),
    this.id_route = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  static Insertable<DrawRoute> custom({
    Expression<int> id,
    Expression<String> id_route,
    Expression<double> latitude,
    Expression<double> longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (id_route != null) 'id_route': id_route,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  DrawRoutesCompanion copyWith(
      {Value<int> id,
      Value<String> id_route,
      Value<double> latitude,
      Value<double> longitude}) {
    return DrawRoutesCompanion(
      id: id ?? this.id,
      id_route: id_route ?? this.id_route,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (id_route.present) {
      map['id_route'] = Variable<String>(id_route.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawRoutesCompanion(')
          ..write('id: $id, ')
          ..write('id_route: $id_route, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $DrawRoutesTable extends DrawRoutes
    with TableInfo<$DrawRoutesTable, DrawRoute> {
  final GeneratedDatabase _db;
  final String _alias;
  $DrawRoutesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _id_routeMeta = const VerificationMeta('id_route');
  GeneratedTextColumn _id_route;
  @override
  GeneratedTextColumn get id_route => _id_route ??= _constructIdRoute();
  GeneratedTextColumn _constructIdRoute() {
    return GeneratedTextColumn(
      'id_route',
      $tableName,
      true,
    );
  }

  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  GeneratedRealColumn _latitude;
  @override
  GeneratedRealColumn get latitude => _latitude ??= _constructLatitude();
  GeneratedRealColumn _constructLatitude() {
    return GeneratedRealColumn(
      'latitude',
      $tableName,
      true,
    );
  }

  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  GeneratedRealColumn _longitude;
  @override
  GeneratedRealColumn get longitude => _longitude ??= _constructLongitude();
  GeneratedRealColumn _constructLongitude() {
    return GeneratedRealColumn(
      'longitude',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, id_route, latitude, longitude];
  @override
  $DrawRoutesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'draw_routes';
  @override
  final String actualTableName = 'draw_routes';
  @override
  VerificationContext validateIntegrity(Insertable<DrawRoute> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id_route')) {
      context.handle(_id_routeMeta,
          id_route.isAcceptableOrUnknown(data['id_route'], _id_routeMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude'], _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude'], _longitudeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrawRoute map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DrawRoute.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DrawRoutesTable createAlias(String alias) {
    return $DrawRoutesTable(_db, alias);
  }
}

class InfoRoute extends DataClass implements Insertable<InfoRoute> {
  final String id;
  final String info;
  final String type;
  InfoRoute({this.id, this.info, this.type});
  factory InfoRoute.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return InfoRoute(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      info: stringType.mapFromDatabaseResponse(data['${effectivePrefix}info']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || info != null) {
      map['info'] = Variable<String>(info);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  InfoRoutesCompanion toCompanion(bool nullToAbsent) {
    return InfoRoutesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory InfoRoute.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return InfoRoute(
      id: serializer.fromJson<String>(json['id']),
      info: serializer.fromJson<String>(json['info']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'info': serializer.toJson<String>(info),
      'type': serializer.toJson<String>(type),
    };
  }

  InfoRoute copyWith({String id, String info, String type}) => InfoRoute(
        id: id ?? this.id,
        info: info ?? this.info,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('InfoRoute(')
          ..write('id: $id, ')
          ..write('info: $info, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(info.hashCode, type.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is InfoRoute &&
          other.id == this.id &&
          other.info == this.info &&
          other.type == this.type);
}

class InfoRoutesCompanion extends UpdateCompanion<InfoRoute> {
  final Value<String> id;
  final Value<String> info;
  final Value<String> type;
  const InfoRoutesCompanion({
    this.id = const Value.absent(),
    this.info = const Value.absent(),
    this.type = const Value.absent(),
  });
  InfoRoutesCompanion.insert({
    this.id = const Value.absent(),
    this.info = const Value.absent(),
    this.type = const Value.absent(),
  });
  static Insertable<InfoRoute> custom({
    Expression<String> id,
    Expression<String> info,
    Expression<String> type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (info != null) 'info': info,
      if (type != null) 'type': type,
    });
  }

  InfoRoutesCompanion copyWith(
      {Value<String> id, Value<String> info, Value<String> type}) {
    return InfoRoutesCompanion(
      id: id ?? this.id,
      info: info ?? this.info,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InfoRoutesCompanion(')
          ..write('id: $id, ')
          ..write('info: $info, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $InfoRoutesTable extends InfoRoutes
    with TableInfo<$InfoRoutesTable, InfoRoute> {
  final GeneratedDatabase _db;
  final String _alias;
  $InfoRoutesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _infoMeta = const VerificationMeta('info');
  GeneratedTextColumn _info;
  @override
  GeneratedTextColumn get info => _info ??= _constructInfo();
  GeneratedTextColumn _constructInfo() {
    return GeneratedTextColumn(
      'info',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, info, type];
  @override
  $InfoRoutesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'info_routes';
  @override
  final String actualTableName = 'info_routes';
  @override
  VerificationContext validateIntegrity(Insertable<InfoRoute> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info'], _infoMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InfoRoute map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return InfoRoute.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $InfoRoutesTable createAlias(String alias) {
    return $InfoRoutesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $DrawRoutesTable _drawRoutes;
  $DrawRoutesTable get drawRoutes => _drawRoutes ??= $DrawRoutesTable(this);
  $InfoRoutesTable _infoRoutes;
  $InfoRoutesTable get infoRoutes => _infoRoutes ??= $InfoRoutesTable(this);
  UsersDao _usersDao;
  UsersDao get usersDao => _usersDao ??= UsersDao(this as AppDatabase);
  DrawRoutesDao _drawRoutesDao;
  DrawRoutesDao get drawRoutesDao =>
      _drawRoutesDao ??= DrawRoutesDao(this as AppDatabase);
  InfoRoutesDao _infoRoutesDao;
  InfoRoutesDao get infoRoutesDao =>
      _infoRoutesDao ??= InfoRoutesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, drawRoutes, infoRoutes];
}
