import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesPage extends StatefulWidget {
  @override
  _ThemesPageState createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  int selectedThemeIndex = 0;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((pref) {
      setState(() {
        selectedThemeIndex = pref.getInt('theme');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //var _height = MediaQuery.of(context).size.height;
    var _width = Constants.getWidth(context);

    buildDefaultThemeWidget() {
      return InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          setState(() {
            selectedThemeIndex = 0;
          });
        },
        child: Container(
          height: _width / 3,
          width: _width / 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.4),
                Colors.blue.withOpacity(0.4)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
                width: selectedThemeIndex == 0 ? 3.0 : 1.0,
                color: Colors.red,
                style: BorderStyle.solid),
            color: Colors.white.withOpacity(0.65),
          ),
          child: Center(
            child: Text(
              'Default',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      );
    }

    buildRockThemeWidget() {
      return InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          setState(() {
            selectedThemeIndex = 2;
          });
        },
        child: Container(
          height: _width / 3,
          width: _width / 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.4),
                  Colors.blue.withOpacity(0.4)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                  width: selectedThemeIndex == 2 ? 3.0 : 1.0,
                  color: Colors.red,
                  style: BorderStyle.solid),
              image: DecorationImage(
                  image: AssetImage('assets/images/rock.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.65), BlendMode.hardLight))),
          child: Center(
            child: Text(
              'Rock',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      );
    }

    buildRomanticThemeWidget() {
      return InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          setState(() {
            selectedThemeIndex = 1;
          });
        },
        child: Container(
          height: _width / 3,
          width: _width / 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.4),
                  Colors.blue.withOpacity(0.4)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                  width: selectedThemeIndex == 1 ? 3.0 : 1.0,
                  color: Colors.red,
                  style: BorderStyle.solid),
              image: DecorationImage(
                  image: AssetImage('assets/images/romantic.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.65), BlendMode.hardLight))),
          child: Center(
            child: Text(
              'Romantic',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      );
    }

    buildPopThemeWidget() {
      return InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          setState(() {
            selectedThemeIndex = 3;
          });
        },
        child: Container(
          height: _width / 3,
          width: _width / 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.4),
                Colors.blue.withOpacity(0.4)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
                width: selectedThemeIndex == 3 ? 3.0 : 1.0,
                color: Colors.red,
                style: BorderStyle.solid),
            image: DecorationImage(
                image: AssetImage('assets/images/pop.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.65), BlendMode.hardLight)),
          ),
          child: Center(
            child: Text(
              'Pop',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 10.0,
          children: <Widget>[
            Wrap(
              direction: Axis.horizontal,
              spacing: 10.0,
              children: <Widget>[
                buildDefaultThemeWidget(),
                buildRomanticThemeWidget(),
              ],
            ),
            Wrap(
              spacing: 10.0,
              direction: Axis.horizontal,
              children: <Widget>[buildRockThemeWidget(), buildPopThemeWidget()],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Apply'),
        icon: Icon(Icons.navigate_next),
        onPressed: () async {
          var pref = await SharedPreferences.getInstance();

          if (selectedThemeIndex == null) {
            return;
          } else
            switch (selectedThemeIndex) {
              case 0:
                pref.setInt("theme", 0);
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) {
                    return false;
                  });
                });
                break;
              case 1:
                pref.setInt("theme", 1);
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) {
                    return false;
                  });
                });
                break;
              case 2:
                pref.setInt("theme", 2);
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) {
                    return false;
                  });
                });
                break;
              case 3:
                pref.setInt("theme", 3);
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) {
                    return false;
                  });
                });
                break;
              default:
                pref.setInt("theme", 0);
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) {
                    return false;
                  });
                });
                break;
            }
        },
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
