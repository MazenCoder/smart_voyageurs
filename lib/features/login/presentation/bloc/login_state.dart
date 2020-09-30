part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  const InitialLoginState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  const LoadingLoginState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedLoginState extends LoginState {
  final User user;
  const LoadedLoginState({this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class ErrorLoginState extends LoginState {
  final String message;
  const ErrorLoginState({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}