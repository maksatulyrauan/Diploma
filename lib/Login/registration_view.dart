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

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  TextEditingController nameController;
  TextEditingController surnameController;
  TextEditingController passwordController;
  TextEditingController passwordRepeatController;
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = new TextEditingController();
    passwordRepeatController = new TextEditingController();
    emailController = new TextEditingController();
    surnameController = new TextEditingController();
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
                        GestureDetector(
                          onTap: () {
                            loginPageNotifier.currentPage = 0;
                          },
                          child: Container(
                            child: Text(
                              'Вход',
                              style: CustomTextStyle().regular(context, FontSize.f20, CustomColor().appGray),
                            ),
                          ),
                        ),
                        Text(
                          'Регистрация',
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
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: CustomColor().appBlue,
                            ),
                            child: FlatButton(
                              onPressed: () {
                                _userRegister(loginPageNotifier);
                              },
                              child: Text(
                                'Зарегистрироваться',
                                textAlign: TextAlign.center,
                                style: CustomTextStyle().bold(context, FontSize.f16, Colors.white),
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

//  var maskFormatter = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  Widget buildRow() {
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
                minLines: 1,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите вам E-mail',
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
              'Ваше имя',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: nameController,
                minLines: 1,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите ваше имя',
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
              'Ваша фамилия',
              style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: surnameController,
                minLines: 1,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Введите вашу фамилию',
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
          height: 60,
        ),
      ],
    );
  }



  _userRegister(LoginPageNotifier loginPageNotifier) async {

    final email = emailController.text;
    print(email);

    final name = nameController.text;
    print(name);

    final surname = surnameController.text;
    print(surname);

    final password = passwordController.text;
    print(password);
    final repeatPassword = passwordRepeatController.text;

    print(repeatPassword);



    if(email == null || email == '') {
      showAlert(context, 'Введите ваш E-mail');
    }
    else {
      if(name == null || name == '') {
        showAlert(context, 'Введите ваше имя');
      }
      else {
        if(surname == null || surname == '') {
          showAlert(context, 'Введите вашу фамилию');
        }
        else {
          if(password == null || password == '') {
            showAlert(context, 'Введите пароль');
          }
          else {
            if(repeatPassword == null || repeatPassword != password) {
              showAlert(context, 'Пароли не совпадают');
            }
            else {
              ApiManager().userRegister(email, name, surname, password, () {

              }, (errorCodeType) {
                ErrorHandler().showAlert(context, errorCodeType);
              });
            }
          }
        }
      }
    }
  }
}

void showAlert(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) => showConfirmation(context, text),
  );
}

Widget showConfirmation(BuildContext context, String text) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: CustomTextStyle().regular(
                context, FontSize.f14, CustomColor().appGray),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: CustomColor().appBlue,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ОК',
                style: CustomTextStyle().bold(
                    context, FontSize.f12, CustomColor().appBlueLight),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}