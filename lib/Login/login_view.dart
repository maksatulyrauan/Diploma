import 'package:diploma_note/Login/registration_view.dart';
import 'package:diploma_note/Models/Notifiers/app_state_notifier.dart';
import 'package:diploma_note/Models/Notifiers/login_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginPageNotifier>(
      builder: (context, loginPageNotifier, _) => Expanded(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Вход',
                          style: CustomTextStyle().medium(context, FontSize.f20, Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginPageNotifier.currentPage = 1;
                          },
                          child: Container(
                            child: Text(
                              'Регистрация',
                              style: CustomTextStyle().regular(context, FontSize.f20, CustomColor().appGray),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 1,
                      itemBuilder: (context, position) {
                        return buildRow(loginPageNotifier);
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: CustomColor().appBlue,
                            ),
                            child: Consumer<AppStateNotifier>(
                              builder: (context, appStateNotifier, _) => FlatButton(
                                onPressed: () {
                                  _userLogin(appStateNotifier);
                                },
                                child: Text(
                                  'Войти',
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle().bold(context, FontSize.f16, Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20 + Constants().safeAreaBottomHeight),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Выполняя вход, вы соглашаетесь\n',
                        style: CustomTextStyle().medium(context, FontSize.f10, CustomColor().appGray),
                        children: <TextSpan>[
                          TextSpan(
//                            recognizer: TapGestureRecognizer()..onTap = () => launch("http://tuktuk.kz/terms-of-use"),
                            text: 'с правилам пользования\n',
                            style: CustomTextStyle().medium(context, FontSize.f10, Colors.black, underlined: true),
                          ),
                          TextSpan(
//                            recognizer: TapGestureRecognizer()..onTap = () => launch("http://tuktuk.kz/privacy-policy"),
                            text: 'и политикой конфиденциальности',
                            style: CustomTextStyle().medium(context, FontSize.f10, Colors.black, underlined: true),
                          ),
                        ],
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

  _userLogin(AppStateNotifier appStateNotifier) async {

    final email = emailController.text;

    final password = passwordController.text;

    if(email == null || email == '') {
      showAlert(context, 'Введите ваш E-mail');
    }
    else {
      if(password == null || password == '') {
        showAlert(context, 'Введите пароль');
      }
      else {
        ApiManager().userLogin(email, password, () {
          appStateNotifier.appState = AppState.main;
        }, (errorCodeType) {
          ErrorHandler().showAlert(context, errorCodeType);
        });
      }
    }
  }

//  var maskFormatter = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  Widget buildRow(LoginPageNotifier loginPageNotifier) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'E-mail',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: emailController,
                autocorrect: false,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите ваш E-mail',
                  hintStyle: CustomTextStyle().medium(context, FontSize.f14, CustomColor().appGray),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              'Пароль',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                minLines: 1,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите пароль',
                  hintStyle: CustomTextStyle().medium(context, FontSize.f14, CustomColor().appGray),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    loginPageNotifier.currentPage = 3;
                  },
                  child: Container(
                    child: Text(
                      'Забыли пароль?',
                      style: CustomTextStyle().medium(context, FontSize.f12, CustomColor().appBlue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


}
