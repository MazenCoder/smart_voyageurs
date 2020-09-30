part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class Auth extends SplashEvent {
  final InputLogin login;
  const Auth({this.login});

  @override
  List<Object> get props => [login];
}
