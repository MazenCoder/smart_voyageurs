import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/ui/loading_dialog.dart';
import 'package:smart_voyageurs/core/util/flash_helper.dart';
import 'package:smart_voyageurs/core/util/image_helper.dart';
import 'package:smart_voyageurs/core/util/color_helper.dart';
import 'package:smart_voyageurs/core/util/str_helper.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> with SingleTickerProviderStateMixin {

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
    final db = Provider.of<AppDatabase>(context);
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
                      ImageHelper.ACCOUNT,
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
                          child: Text('create_my_account'.tr()),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            LoadingDialog.show(context);
                            await db.usersDao.insertUsers(User(
                              email: _emailController.text.trim(),
                              password: sl<AppUtils>().generateMd5(
                                _passwordController.text.trim(),
                              ),
                            )).whenComplete(() async {
                              _emailController.clear();
                              _passwordController.clear();
                              LoadingDialog.hide(context);
                              FlashHelper.successBar(context, message: 'successfully'.tr());
                              await Future.delayed(Duration(seconds: 1))
                                .whenComplete(() => Navigator.pop(context),
                              );
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
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
