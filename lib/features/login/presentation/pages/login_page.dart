import 'package:smart_voyageurs/features/login/presentation/widgets/initial_login.dart';
import 'package:smart_voyageurs/features/login/presentation/widgets/loaded_login.dart';
import 'package:smart_voyageurs/features/login/presentation/bloc/login_bloc.dart';
import 'package:smart_voyageurs/features/home/presentation/pages/home_page.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:smart_voyageurs/core/util/flash_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_voyageurs/core/ui/loading_app.dart';
import 'package:smart_voyageurs/core/ui/error_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: BlocProvider(
            create: (_) => sl<LoginBloc>(),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is ErrorLoginState) {
                  FlashHelper.errorBar(context, message:
                    state.message ?? 'something_wrong'.tr()
                  );
                }

                if (state is LoadedLoginState) {
                  if (state.user == null) {
                    FlashHelper.errorBar(context, message: 'something_wrong'.tr());
                  } else {
                    FlashHelper.successBar(context, message: 'successfully'.tr());
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomePage(state.user)
                    ));

                  }
                }
              },
              builder: (context, state) {
                if (state is InitialLoginState) {
                  return InitialLogin();
                } else if (state is LoadingLoginState) {
                  return LoadingApp();
                } else if (state is LoadedLoginState) {
                  return LoadedLogin(user: state.user);
                } else if (state is ErrorLoginState) {
                  return LoadedLogin(user: null);
                } else {
                  return ErrorApp();
                }
              },
            )
        ),
      ),
    );
  }
}
