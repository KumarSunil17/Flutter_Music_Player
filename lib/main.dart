import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/splash_page.dart';
import 'package:flutter_music_player/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme;
  var isLoading = true;

  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Music',
      theme: isLoading ? Constants.lightTheme : theme,
      home: isLoading ? Container() : SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  getTheme() async {
    await SharedPreferences.getInstance().then((s) {
      var val = s.getInt("theme");
      print('theme $val');

      if (val == null) {
        theme = Constants.lightTheme;
      } else if (val == 1) {
        theme = Constants.romanticTheme;
      } else if (val == 2) {
        theme = Constants.rockTheme;
      } else if (val == 3) {
        theme = Constants.popTheme;
      } else {
        theme = Constants.lightTheme;
      }
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }
}
