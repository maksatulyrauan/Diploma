import 'package:diploma_note/Models/Notifiers/language_notifier.dart';
import 'package:diploma_note/Models/Notifiers/login_page_notifier.dart';
import 'package:diploma_note/Models/Notifiers/main_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/Notifiers/app_state_notifier.dart';
import 'main_view.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

//  prefs.setString("token", null);
  Constants().token = await prefs.getString("token");

  if(Constants().token != null && Constants().token != '') {
    Constants().state = AppState.main;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateNotifier()),
        ChangeNotifierProvider(create: (context) => MainPageNotifier()),
        ChangeNotifierProvider(create: (context) => LanguageNotfier()),
        ChangeNotifierProvider(create: (context) => LoginPageNotifier()),
      ],
      child: MaterialApp(
        title: 'Note',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
        ),
        home: MainView(),
      ),
    );
  }
}