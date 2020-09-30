import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_voyageurs/core/error/exceptions.dart';
import 'package:smart_voyageurs/core/util/keys.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';




abstract class LoginLocalDataSource {
  Future<void> cacheLoginInput(InputLogin inputLogin);
  Future<void> cacheUser(User user);
  Future<User> getCacheUser();

}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {

  final logger = Logger();

  final SharedPreferences preferences;
  final AppDatabase db;
  LoginLocalDataSourceImpl({
    @required this.preferences,
    @required this.db,
  });

  @override
  Future<void> cacheUser(User user) async {
    await preferences.setString(Keys.CACHED_USER, json.encode(user.toJson()));
  }

  @override
  Future<void> cacheLoginInput(InputLogin inputLogin) async {
    await preferences.setString(Keys.CACHED_LOGIN_INPUT, json.encode(inputLogin.toJson()));
  }

  @override
  Future<User> getCacheUser() {
    final jsonString = preferences.getString(Keys.CACHED_USER);
    if (jsonString != null) {
      logger.i(jsonString);
      return Future.value(User.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}