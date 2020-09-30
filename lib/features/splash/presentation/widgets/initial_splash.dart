import 'package:smart_voyageurs/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:smart_voyageurs/features/login/presentation/pages/login_page.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class InitialSplash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<InputLogin>(
        future: sl<AppUtils>().getCacheInputLogin(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return Center(
              child: CircularProgressIndicator(),
            );
            default:
              if (snapshot.hasData) {
                BlocProvider.of<SplashBloc>(context)
                  ..add(Auth(login: snapshot.data));
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Image.asset(ImageHelper.LOGO),
                  )
                );
              } else return LoginPage();
          }
        },
      ),
    );
  }
}
