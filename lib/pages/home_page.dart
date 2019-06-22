import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/bottom_nav_pages/album_page.dart';
import 'package:flutter_music_player/pages/bottom_nav_pages/all_songs_page.dart';
import 'package:flutter_music_player/pages/bottom_nav_pages/artist_page.dart';
import 'package:flutter_music_player/pages/bottom_nav_pages/playlist_page.dart';
import 'package:flutter_music_player/pages/bottom_nav_pages/recent_page.dart';
import 'package:flutter_music_player/pages/now_playing.dart';
import 'package:flutter_music_player/utils/bottom_navigation_view.dart';

class HomePage extends StatefulWidget {
  static int _currentIndex = 0;
  static String _title = 'Flutter Music';

  static getCurrentIndex() {
    return _currentIndex;
  }

  static setCurrentIndex(int index) {
    _currentIndex = index;
  }

  static String getActiveTitle() {
    return _title;
  }

  static setActiveTitle(String title) {
    _title = title;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.home),
        title: 'Home',
        color: CupertinoColors.darkBackgroundGray,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.album),
        title: 'Album',
        color: CupertinoColors.destructiveRed,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.music_note),
        title: 'Songs',
        color: CupertinoColors.activeBlue,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.person),
        title: 'Artists',
        color: CupertinoColors.activeOrange,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.playlist_play),
        title: 'Playlist',
        color: CupertinoColors.activeGreen,
        vsync: this,
      ),
    ];
    _navigationViews[HomePage._currentIndex].controller.value = 1.0;
  }

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        setState(() {
          HomePage._title = 'Flutter Music';
        });
        return RecentPage();
      case 1:
        setState(() {
          HomePage._title = 'Album';
        });
        return Album();
      case 2:
        setState(() {
          HomePage._title = 'Songs';
        });
        return AllSongs();
      case 3:
        setState(() {
          HomePage._title = 'Artist';
        });
        return Artist();
      case 4:
        setState(() {
          HomePage._title = 'Playlist';
        });
        return Playlist();
      default:
        setState(() {
          HomePage._title = '-Error-';
        });
        return Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NowPlayingPage()));
        },
        child: Icon(Icons.play_arrow),
      ),
      body: getDrawerItemWidget(HomePage.getCurrentIndex()),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationViews
            .map<BottomNavigationBarItem>(
                (NavigationIconView navigationView) => navigationView.item)
            .toList(),
        currentIndex: HomePage._currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() {
            _navigationViews[HomePage._currentIndex].controller.reverse();
            HomePage._currentIndex = index;
            switch (index) {
              case 0:
                HomePage._title = 'Flutter Music';
                break;
              case 1:
                HomePage._title = 'Album';
                break;
              case 2:
                HomePage._title = 'Songs';
                break;
              case 3:
                HomePage._title = 'Artist';
                break;
              case 4:
                HomePage._title = 'Playlist';
                break;
              default:
                HomePage._title = '-Error-';
            }
            _navigationViews[HomePage._currentIndex].controller.forward();
          });
        },
      ),
    );
  }
}
