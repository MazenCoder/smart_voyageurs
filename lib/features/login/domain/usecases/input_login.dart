import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


class InputLogin extends Equatable {

  final String email;
  final String password;

  InputLogin({
    @required this.email,
    @required this.password,
  });

  factory InputLogin.fromJson(Map<String, dynamic> json) => InputLogin(
    email: json["email"],
    password: json["password"],
  );


  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  @override
  List<Object> get props => [email, password];

}