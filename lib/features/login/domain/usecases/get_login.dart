import 'package:smart_voyageurs/features/login/domain/repositories/login_repository.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/usecases/usecase.dart';
import 'package:smart_voyageurs/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetLogin implements UseCase<User, InputLogin> {

  final LoginRepository repository;
  GetLogin({@required this.repository});

  @override
  Future<Either<Failure, User>> call(InputLogin params) async {
    return await repository.getAuth(params);
  }
}