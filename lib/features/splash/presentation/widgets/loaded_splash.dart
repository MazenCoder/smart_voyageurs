import 'package:smart_voyageurs/features/login/presentation/pages/login_page.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:flutter/material.dart';


class LoadedSplash extends StatelessWidget {

  final User user;
  LoadedSplash({this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: FutureBuilder(
          future: sl<AppUtils>().logOut(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting: return Center(
                child: CircularProgressIndicator(),
              );
              default: return LoginPage();
            }
          },
        ),
      );
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
