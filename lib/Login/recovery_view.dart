import 'package:diploma_note/Models/Notifiers/login_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RecoveryView extends StatefulWidget {
  @override
  _RecoveryViewState createState() => _RecoveryViewState();
}

class _RecoveryViewState extends State<RecoveryView> {

  TextEditingController phoneController;
  TextEditingController passwordController;
  TextEditingController passwordRepeatController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(
      text: '+7 (_ _ _)',
    );
    passwordController = new TextEditingController();
    passwordRepeatController = new TextEditingController();
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
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Восстановление\nпароля',
                          style: CustomTextStyle().medium(context, FontSize.f20, Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 1,
                      itemBuilder: (context, position) {
                        return buildRow();
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              color: CustomColor().appBlue,
                            ),
                            child: FlatButton(
                              onPressed: () {
                                passwordRecover(loginPageNotifier);
//                                loginPageNotifier.currentPage = 0;
                              },
                              child: Text(
                                'Сбросить пароль',
                                textAlign: TextAlign.center,
                                style: CustomTextStyle().bold(context, FontSize.f16, Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColor().appBlue,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: FlatButton(
                            onPressed: () {
                              loginPageNotifier.currentPage = 0;
                            },
                            child: Text(
                              'К странице входа',
                              textAlign: TextAlign.center,
                              style: CustomTextStyle().regular(context, FontSize.f16, CustomColor().appBlue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
  var maskFormatter = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });


  Widget buildRow() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Номер телефона',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                minLines: 1,
                maxLines: 1,
                autocorrect: false,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите номер телефона',
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
                inputFormatters: [
                  maskFormatter,
                ],
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
        Row(
          children: <Widget>[
            Text(
              'Повторите пароль',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: passwordRepeatController,
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
      ],
    );
  }

  passwordRecover(LoginPageNotifier loginPageNotifier) async {
//    var phone = phoneController.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', '');
//    final phoneNumber = '+' + phone;
//    recoveryPassword = passwordController.text;
//    final repeatPassword = passwordRepeatController.text;
//
//    if(recoveryPassword == repeatPassword) {
//
//      userId = await ApiManager().recoverPassword(phoneNumber, () {
//        loginPageNotifier.currentPage = 2;
//      }, (errorCodeType) {
//        ErrorHandler().showAlert(context, errorCodeType);
//      });
//    }
//    else {
//      showAlert(context, 'Пароли не совпадают');
//    }
  }
}
String recoveryPassword;