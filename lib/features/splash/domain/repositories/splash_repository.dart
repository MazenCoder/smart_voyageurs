import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class SplashRepository {
  Future<Either<Failure, User>> getAuth(InputLogin input);
}