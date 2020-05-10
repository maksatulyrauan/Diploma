import 'package:diploma_note/Login/confirm_view.dart';
import 'package:diploma_note/Login/login_view.dart';
import 'package:diploma_note/Login/recovery_view.dart';
import 'package:diploma_note/Login/registration_view.dart';
import 'package:diploma_note/Models/Notifiers/login_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPageNotifier>(
      builder: (context, loginPageNotifier, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Transform.translate(
          offset: Offset(
            0.0,
            _keyboardIsVisible() ? -100.0 : 0.0,
          ),
          child: Container(
            color: CustomColor().appBlue,
            child: Stack(
              children: <Widget>[
//                Column(
//                  children: <Widget>[
//                    SizedBox(height: Constants().statusBarHeight + 25,),
//                    Image(
//                      image: AssetImage('assets/images/logo.png'),
//                      height: 75,
//                      width: Constants().width,
//                    ),
//                  ],
//                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: loginPageNotifier.currentPage == 0 || loginPageNotifier.currentPage == 3 ? Constants().statusBarHeight + 125 : Constants().statusBarHeight + 75,
                    ),
                    loginPageNotifier.currentPage == 0 ? LoginView() :
                    loginPageNotifier.currentPage == 1 ? RegistrationView() :
                    loginPageNotifier.currentPage == 2 ? ConfirmView() : RecoveryView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}
