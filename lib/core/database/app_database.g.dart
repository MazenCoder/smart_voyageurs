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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  UsersDao _usersDao;
  UsersDao get usersDao => _usersDao ??= UsersDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
