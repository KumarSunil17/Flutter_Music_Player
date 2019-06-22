import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class AllSongs extends StatefulWidget {
  @override
  _AllSongsState createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  List<Song> songs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    initSongs();
  }

  initSongs() async {
    //songs = await Constants.db.fetchSongs();
    setState(() {
      isLoading = false;
    });
  }

  dynamic getImage(Song song) {
    return song.albumArt == null
        ? null
        : new File.fromUri(Uri.parse(song.albumArt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: //isLoading
            //?
            Center(
      child: CircularProgressIndicator(),
    )

//          : ListView.builder(
//              itemCount: songs.length,
//              itemBuilder: (context, i) {
//                return Column();
//              }),
        );
  }
}
