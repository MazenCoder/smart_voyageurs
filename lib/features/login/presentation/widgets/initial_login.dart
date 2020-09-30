import 'package:smart_voyageurs/features/login/presentation/widgets/create_account.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_voyageurs/features/login/presentation/bloc/login_bloc.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:smart_voyageurs/core/util/color_helper.dart';
import 'package:smart_voyageurs/core/util/str_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:smart_voyageurs/core/util/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class InitialLogin extends StatefulWidget {
  @override
  _InitialLoginState createState() => _InitialLoginState();
}

class _InitialLoginState extends State<InitialLogin>
    with SingleTickerProviderStateMixin {

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController animController;
  Animation<double> animation;
  bool _obscureText = true;
  
  @override
  void initState() {
    _initAnimation();
  }

  void _initAnimation() {
    try {
      animController = AnimationController(
          duration: Duration(seconds: 5), vsync: this);
      final curvedAnimation = CurvedAnimation(
        parent: animController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      animation = Tween<double>(
          begin: 0, end: 2 * math.pi).animate(curvedAnimation)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            animController.forward();
          }}
        );
      animController.forward();
    }catch(e) {
      print("error, _initAnimation: $e");
      animController.dispose();
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: FadeTransition(
                  opacity: animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
                    child: new Image.asset(
                      ImageHelper.LOGO,
                      height: 80,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, bottom: 30),
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'email_address'.tr(),
                          icon: new Icon(MdiIcons.account),
                        ),
                        validator: (val) {
                          if(val.isEmpty) {
                            return 'required_field'.tr();
                          } else if (!RegExp(StrHelper.patternEmail).hasMatch(val)) {
                            return 'email_valid'.tr();
                          } else return null;
                        },
                      ),
                      new SizedBox(height: 8,),
                      new TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'password'.tr(),
                          icon: new Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (val) {
                          if(val.isEmpty)
                            return 'required_field'.tr();
                          return null;
                        },
                      ),
                      new SizedBox(height: 16,),
                      new RaisedButton.icon(
                        icon: Icon(MdiIcons.account),
                        color: Colors.pink.shade700,
                        textColor: ColorHelper.COLOR_WITHE,
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          child: Text('login'.tr()),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            BlocProvider.of<LoginBloc>(context)
                              ..add(Login(login: InputLogin(
                                email: _emailController.text.trim(),
                                password: sl<AppUtils>().generateMd5(
                                  _passwordController.text.trim(),
                                ),
                              )),
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                      ),
                      new SizedBox(height: 16),
                      FlatButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreateAccount()
                        )),
                        child: Text('create_account'.tr(),
                          style: subTextStyle,
                        ),
                      ),
                      new SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
