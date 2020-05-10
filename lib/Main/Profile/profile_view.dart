import 'package:diploma_note/Main/Profile/settings_view.dart';
import 'package:diploma_note/Models/Notifiers/app_state_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Constants().statusBarHeight),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: 1,
              itemBuilder: (context, position) {
                return buildRow();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Consumer<AppStateNotifier>(
              builder: (context, appStateNotifier, _) => GestureDetector(
                onTap: () {
                  ApiManager().userLogOut(() {
                    appStateNotifier.appState = AppState.login;
                  }, (errorCodeType) {
                    ErrorHandler().showAlert(context, errorCodeType);
                  });
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: CustomColor().appGreen,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      Strings().signOut,
                      style: CustomTextStyle().regular(context, FontSize.f16, Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              left: 20,
              right: 20,
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: Strings().privacyPolicy + '\n' + Strings().termsOfUse,
                  style: CustomTextStyle().medium(context, FontSize.f10, Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/alex.jpg'),
            radius: 50,
            backgroundColor: Colors.transparent,
          ),
          Text(
            'Максатулы Рауан',
            style: CustomTextStyle().regular(context, FontSize.f18, Colors.black),
          ),
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Strings().chat,
                style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
              ),
              Icon(
                Icons.arrow_right,
              )
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsView()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Strings().settings,
                  style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
                ),
                Icon(
                  Icons.arrow_right,
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Strings().support,
                style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
              ),
              Icon(
                Icons.arrow_right,
              )
            ],
          ),
        ],
      ),
    );
  }
}
