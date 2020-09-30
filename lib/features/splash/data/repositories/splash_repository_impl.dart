import 'package:smart_voyageurs/features/splash/domain/repositories/splash_repository.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/error/failures.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';



class SplashRepositoryImpl implements SplashRepository {

  final AppDatabase db;
  SplashRepositoryImpl({@required this.db});

  final logger = Logger();

  @override
  Future<Either<Failure, User>> getAuth(InputLogin input) async {
    final user = await db.usersDao.getUsersByNameAndPass(email: input.email, password: input.password);
    if (user != null) {
      return Right(user);
    } else return Left(CacheFailure(message: "error_connection".tr()));
  }
}