import 'package:smart_voyageurs/features/splash/presentation/widgets/initial_splash.dart';
import 'package:smart_voyageurs/features/splash/presentation/widgets/loaded_splash.dart';
import 'package:smart_voyageurs/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:smart_voyageurs/features/home/presentation/pages/home_page.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:smart_voyageurs/core/util/flash_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_voyageurs/core/ui/loading_app.dart';
import 'package:smart_voyageurs/core/ui/error_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';



class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: BlocProvider(
            create: (_) => sl<SplashBloc>(),
            child: BlocConsumer<SplashBloc, SplashState>(
              listener: (context, state) {
                if (state is ErrorSplashState) {
                  FlashHelper.errorBar(context,
                    message: state.message ?? '' 'something_wrong'.tr(),
                  );
                }

                if (state is LoadedSplashState) {
                  if (state.user == null) {
                    FlashHelper.errorBar(context, message: 'something_wrong'.tr());
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => HomePage(state.user)
                    ));
                  }
                }
              },
              builder: (context, state) {
                if (state is InitialSplashState) {
                  return InitialSplash();
                } else if (state is LoadingSplashState) {
                  return LoadingApp();
                } else if (state is LoadedSplashState) {
                  return LoadedSplash(user: state.user);
                } else if (state is ErrorSplashState) {
                  return ErrorApp(state.message);
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



