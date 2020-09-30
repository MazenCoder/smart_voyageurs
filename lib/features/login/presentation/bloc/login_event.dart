part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  final InputLogin login;
  const Login({this.login});

  @override
  // TODO: implement props
  List<Object> get props => [login];
}