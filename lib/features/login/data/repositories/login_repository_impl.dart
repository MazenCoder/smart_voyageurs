import 'package:smart_voyageurs/features/login/data/database/login_local_data_source.dart';
import 'package:smart_voyageurs/features/login/domain/repositories/login_repository.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/error/failures.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class LoginRepositoryImpl implements LoginRepository {

  final LoginLocalDataSource localDataSource;
  final SharedPreferences preferences;
  final AppDatabase db;

  final logger = Logger();

  LoginRepositoryImpl({
    @required this.localDataSource,
    @required this.preferences,
    @required this.db,
  });


  @override
  Future<Either<Failure, User>> getAuth(InputLogin login) async {
    print('----------------');
    print(login.toJson());
    final user = await db.usersDao.getUsersByNameAndPass(email: login.email, password: login.password);
    if (user != null) {
      await localDataSource.cacheLoginInput(login);
      return Right(user);
    } else {
      return Left(CacheFailure(message: "user_not_found".tr()));
    }
  }
}