import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/get_login.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final GetLogin getLogin;
  LoginBloc({@required this.getLogin}) : super(InitialLoginState());

  final logger = Logger();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      try {
        yield LoadingLoginState();
        Either<Failure, User> either = await getLogin.call(event.login);
        yield* either.fold((failure) async* {
          logger.e('failure');

          var getType = failure.props?.elementAt(0);
          print("getType message: $getType");
          print("getType first: ${failure.props.first}");

          String messageFailure = either.fold((failure) => failure.props?.elementAt(0) ?? '', (_) => '');
          print("messageFailure: $messageFailure");
          yield ErrorLoginState(message: messageFailure);

        }, (values) async* {
          logger.d('collaborateur');
          yield LoadedLoginState(user: values);
        });

      } catch(e) {
        logger.e(e);
        yield ErrorLoginState(message: e.toString());
      }
    }
  }
}
