import 'package:smart_voyageurs/features/splash/presentation/pages/splash_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:smart_voyageurs/core/util/color_helper.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class ErrorApp extends StatelessWidget {
  final String message;
  ErrorApp([this.message]);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('oops'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Image.asset(ImageHelper.ERROR, height: 220),
                  SizedBox(height: 5,),
                  Text(message != null ? message : 'something_wrong'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  RaisedButton.icon(
                    icon: Icon(MdiIcons.refresh),
                    color: ColorHelper.COLOR_PINK[400],
                    textColor: ColorHelper.COLOR_WITHE,
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('try_again'.tr()),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SplashPage()
                      ));
                      // sl<AppUtils>().logOut();
                      //Navigator.pushReplacementNamed(context, Constant.SPLASH_PAGE);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
