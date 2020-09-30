import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/features/splash/domain/usecases/get_auth.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'dart:async';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final GetAuth getAuth;
  SplashBloc({@required this.getAuth}) : super(InitialSplashState());

  final logger = Logger();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is Auth) {
      try {
        yield LoadingSplashState();
        Either<Failure, User> either = await getAuth.call(event.login);
        yield* either.fold((failure) async* {
          logger.e('failure');

          var getType = failure.props?.elementAt(0);
          print("getType message: $getType");
          print("getType first: ${failure.props.first}");

          String messageFailure = either.fold((failure) => failure.props?.elementAt(0) ?? '', (_) => '');
          print("messageFailure: $messageFailure");
          yield ErrorSplashState(message: messageFailure);

        }, (values) async* {
          logger.d('collaborateur');
          yield LoadedSplashState(user: values);
        });

      } catch(e) {
        logger.e(e);
        yield ErrorSplashState(message: e.toString());
      }
    }
  }
}
