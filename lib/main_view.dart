import 'package:diploma_note/Login/login_screen.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Main/main_screen.dart';
import 'Models/Notifiers/app_state_notifier.dart';
import 'Utilities/enumerations.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    Constants().width = MediaQuery.of(context).size.width;
    Constants().statusBarHeight = MediaQuery.of(context).padding.top;
    Constants().safeAreaBottomHeight = MediaQuery.of(context).padding.bottom;
    Constants().customPadding = CustomPadding();
    return Consumer<AppStateNotifier>(
      builder: (context, appStateNotifier, _) => appStateNotifier.appState == AppState.main
          ? MainScreen() : LoginScreen(),
    );
  }
}
