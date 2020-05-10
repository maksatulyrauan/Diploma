import 'package:diploma_note/Login/recovery_view.dart';
import 'package:diploma_note/Models/Notifiers/app_state_notifier.dart';
import 'package:diploma_note/Models/Notifiers/login_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmView extends StatefulWidget {

  @override
  _ConfirmViewState createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new TextEditingController(text: '');
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
                    padding: EdgeInsets.only(top: 40, bottom: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Подтверждение',
                          style: CustomTextStyle().medium(context, FontSize.f20, Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Введите код из СМС',
                        style: CustomTextStyle().semibold(context, FontSize.f12, CustomColor().appBlue),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Center(
                        child: TextField(
                          textCapitalization: TextCapitalization.characters,
                          minLines: 1,
                          maxLines: 1,
                          controller: _controller,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: CustomTextStyle().regular(context, FontSize.f34, Colors.black),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color: CustomColor().appBlue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color: CustomColor().appBlue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
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
//                                    recoveryPassword == null ? confirmPasswordTapped(loginPageNotifier, appStateNotifier) :
//                                    confirmPasswordRecoveryTapped(loginPageNotifier, appStateNotifier);
                                  },
                                  child: Text(
                                    'Подтвердить',
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
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
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
//                                recoveryPassword == null ? loginPageNotifier.currentPage = 1 : loginPageNotifier.currentPage = 0;
                              },
                              child: Text(
                                recoveryPassword == null ? 'К регистрации' : 'В начало',
                                textAlign: TextAlign.center,
                                style: CustomTextStyle().regular(context, FontSize.f16, CustomColor().appBlue),
                              ),
                            ),
                          ),
                        ),
                      ],
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


  void confirmPasswordTapped(LoginPageNotifier loginPageNotifier, AppStateNotifier appStateNotifier) async {

//    final code = _controller.text;
//
//    var url = apiEndpoint + 'users/api/confirm_registration';
//    var jsonString = {'user_id': userId, 'code': code};
//    var pop = json.encode(jsonString);
//    var response = await http.post(url, body: pop);
//
//    if(response.statusCode == 200) {
//      Map<String, dynamic> result = jsonDecode(response.body);
//      sessionId = result['data']['session_id'];
//
//      final prefs = await SharedPreferences.getInstance();
//      prefs.setString('sessionId', sessionId);
//
//      if(state == AppState.courier) {
//        appStateNotifier.appState = AppState.courier;
//      }
//      else {
//        appStateNotifier.appState = AppState.customer;
//      }
//      loginPageNotifier.currentPage = 0;
//
//      final preferences = {'language': selectedLanguageType.index, 'appState': state.index};
//      var preferencesJSON = jsonEncode(preferences);
//
//      var header = {
//        'Content-type': 'application/json',
//        'X-SESSION-ID': sessionId,
//        "Accept": "application/json"
//      };
//      url = apiEndpoint + 'users/api/change_preferences';
//      jsonString = {'data': preferencesJSON};
//      pop = json.encode(jsonString);
//      response = await http.post(url, body: pop, headers: header);
//
//    }
//    else {
//      showAlert(context, 'Что-то пошло не так');
//    }
  }
  void confirmPasswordRecoveryTapped(LoginPageNotifier loginPageNotifier, AppStateNotifier appStateNotifier) async {

//    final code = _controller.text;
//
//    var url = apiEndpoint + 'users/api/confirm_password_reset';
//    var jsonString = {'user_id': userId, 'code': code, 'password': recoveryPassword, 'password_confirmation': recoveryPassword, 'onesignal_id': oneSignalPlayerId};
//    var pop = json.encode(jsonString);
//    var response = await http.post(url, body: pop);
//
//    Map<String, dynamic> result = jsonDecode(response.body);
//    if(response.statusCode == 200) {
//
//      sessionId = result['data']['session_id'];
//
//      final prefs = await SharedPreferences.getInstance();
//      prefs.setString('sessionId', sessionId);
//
//      final role = result['data']['role'];
//
//      if(role == 0) {
//        appStateNotifier.appState = AppState.customer;
//      }
//      else {
//        appStateNotifier.appState = AppState.courier;
//      }
//      loginPageNotifier.currentPage = 0;
//    }
//    else {
//      final data = result['data'];
//      if (data == 'password_too_short') {
//        showAlert(context, 'Пароль слишком короткий');
//      }
//      else {
//        showAlert(context, 'Что-то пошло не так');
//      }
//    }
  }
}

