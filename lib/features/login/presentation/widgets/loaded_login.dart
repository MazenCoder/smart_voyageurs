import 'package:smart_voyageurs/features/login/presentation/pages/login_page.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:flutter/material.dart';


class LoadedLogin extends StatelessWidget {
  final User user;
  LoadedLogin({this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage();
    } else return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Image.asset(ImageHelper.LOGO),
        )
      ),
    );
  }
}
