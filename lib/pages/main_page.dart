import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_player/pages/home_page.dart';
import 'package:flutter_music_player/pages/manu_pages/about_page.dart';
import 'package:flutter_music_player/pages/manu_pages/themes_page.dart';
import 'package:flutter_music_player/ui_components/backdrop.dart';
import 'package:flutter_music_player/utils/app_settings.dart';
import 'package:flutter_music_player/utils/search_delagate.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _delegate = SearchDemoDelegate();
  AnimationController _controller;
  bool _enableSearch = true;
  String _home = 'Home';

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: 1.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMenuOptions(
        {IconData icon, String title, Function onPressed}) {
      return RawMaterialButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width - 100,
          child: Wrap(
            spacing: 10.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
        ),
      );
    }

    Future<bool> _onWillPop() {
      if (HomePage.getCurrentIndex() != 0) {
        setState(() {
          HomePage.setCurrentIndex(0);
        });
      } else
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Music player will be stopped..'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      // MyQueue.player.stop();
                      //exit(0);
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            });
    }

    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            bottom: false,
            child: WillPopScope(
              onWillPop: _onWillPop,
              child: Backdrop(
                controller: _controller,
                backTitle: Text('Menu'),
                frontTitle: AnimatedSwitcher(
                  child: Text(HomePage.getActiveTitle()),
                  duration: Duration(milliseconds: 300),
                ),
                actionBarAction: _enableSearch
                    ? IconButton(
                        tooltip: 'Search',
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          await showSearch(
                              context: context, delegate: _delegate);
                          _scaffoldKey.currentState.openDrawer();
                        },
                      )
                    : Container(),
                backLayer: Container(
                  alignment: Alignment.topCenter,
                  color: Theme.of(context).primaryColor,
                  child: Wrap(
                    runSpacing: 5.0,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      _buildMenuOptions(
                          icon: Icons.home,
                          title: 'Home',
                          onPressed: () {
                            setState(() {
                              _enableSearch = true;

                              HomePage.setCurrentIndex(0);
                              _controller.animateTo(1.0);
                            });
                          }),
                      _buildMenuOptions(
                          icon: Icons.color_lens,
                          title: 'Themes',
                          onPressed: () {
                            setState(() {
                              _enableSearch = false;
                              _home = 'Themes';
                              _controller.animateTo(1.0);
                            });
                          }),
                      _buildMenuOptions(
                          icon: Icons.equalizer,
                          title: 'Equilizer',
                          onPressed: () async {
                            await AppSettings.openEqualizer().whenComplete(() {
                              _controller.animateTo(1.0);
                            });
                          }),
                      _buildMenuOptions(
                          icon: Icons.info,
                          title: 'About',
                          onPressed: () {
                            setState(() {
                              _home = 'About';
                              _enableSearch = false;
                              _controller.animateTo(1.0);
                            });
                          }),
                    ],
                  ),
                ),
//                frontAction: AnimatedSwitcher(
//                    duration: Duration(milliseconds: 300),
//                    switchOutCurve:
//                        Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
//                    switchInCurve:
//                        Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
//                    child: InkWell(
//                      onTap: () {},
//                      child: HomePage.getCurrentIndex() == 0
//                          ? Center(
//                              child: CircleAvatar(
//                                backgroundImage:
//                                    AssetImage('assets/images/music.png'),
//                              ),
//                            )
//                          : IconButton(
//                              icon: const BackButtonIcon(),
//                              tooltip: 'Back',
//                              onPressed: () =>
//                                  setState(() => HomePage.setCurrentIndex(0)),
//                            ),
//                    )),
                frontLayer: _home == 'Home'
                    ? HomePage()
                    : _home == 'Themes' ? ThemesPage() : AboutPage(),
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Future<bool>.value(true);
        });
  }
}
