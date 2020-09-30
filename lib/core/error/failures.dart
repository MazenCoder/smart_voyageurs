import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class CacheFailure extends Failure {

  final String message;

  CacheFailure({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;
  NetworkFailure({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NoDataFailure extends Failure {
  final String message;

  NoDataFailure({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}