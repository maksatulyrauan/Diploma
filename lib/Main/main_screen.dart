import 'package:diploma_note/Main/CreateNote/create_note_view.dart';
import 'package:diploma_note/Main/Favourites/favourites_view.dart';
import 'package:diploma_note/Main/Notes/edit_note_view.dart';
import 'package:diploma_note/Models/Notifiers/main_page_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Notes/notebooks_view.dart';
import 'Profile/profile_view.dart';
import 'Search/search_note_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  Widget _buildOffstageNavigator(int index) {

    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          NotebooksView(),
          SearchNoteView(),
          Text(''),
          FavouritesView(),
          ProfileView(),
        ].elementAt(index);
      },
    };
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MainPageNotifier>(
      builder: (context, mainPageNotifier, _) => WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
          !await _navigatorKeys[_selectedIndex].currentState.maybePop();

          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Stack(
          children: <Widget>[
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  _buildOffstageNavigator(0),
                  _buildOffstageNavigator(1),
                  _buildOffstageNavigator(2),
                  _buildOffstageNavigator(3),
                  _buildOffstageNavigator(4),
                ],
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: CustomColor().appGray,
                        width: 3.0,
                      ),
                    )
                ),
                child: BottomNavigationBar(
                  iconSize: 30,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list,
                        color: _selectedIndex == 0 ? CustomColor().appBlue : CustomColor().appGray,
                      ),
                      title: Text(''),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        color: _selectedIndex == 1 ? CustomColor().appBlue : CustomColor().appGray,
                      ),
                      title: Text(''),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add,
                        color: _selectedIndex == 2 ? CustomColor().appBlue : CustomColor().appGray,
                      ),
                      title: Text(''),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.star,
                        color: _selectedIndex == 3 ? CustomColor().appBlue : CustomColor().appGray,
                      ),
                      title: Text(''),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                        color: _selectedIndex == 4 ? CustomColor().appBlue : CustomColor().appGray,
                      ),
                      title: Text(''),
                    ),
                  ],
                  onTap: (index) {
                    if(index == 2) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNoteView()));
                      return;
                    }
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
            mainPageNotifier.currentPage != 0 ?
            Scaffold(
              body: EditNoteView(),
            ) : Text(''),
          ],
        ),
      ),
    );
  }
}
