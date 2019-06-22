import 'package:flutter/material.dart';

class NowPlayingPage extends StatefulWidget {
  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {},
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: AnimationController(
                vsync: this, duration: Duration(milliseconds: 1000)),
          ),
        ),
      ),
    );
  }
}
