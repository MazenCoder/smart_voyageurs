part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable {
  const SplashState();
}

class InitialSplashState extends SplashState {
  const InitialSplashState();

  @override
  List<Object> get props => [];
}

class LoadingSplashState extends SplashState {
  const LoadingSplashState();

  @override
  List<Object> get props => [];
}

class LoadedSplashState extends SplashState {
  final User user;
  const LoadedSplashState({this.user});

  @override
  List<Object> get props => [user];
}

class ErrorSplashState extends SplashState {
  final String message;
  const ErrorSplashState({this.message});

  @override
  List<Object> get props => [message];
}