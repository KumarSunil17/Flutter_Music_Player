import 'package:flutter/material.dart';
//import 'package:flutter_music_player/database/database_client.dart';

class Constants {
  //static DatabaseClient db;

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color(0xFF2F2FA2),
      primaryColorDark: Color(0xFF242582),
      primaryColorLight: Color(0xFF553D67),
      accentColor: Color(0xFFF64C72),
      iconTheme: IconThemeData(color: Color(0xFF99738E)),
      fontFamily: 'Raleway');
  static ThemeData rockTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color(0xffFCBD34),
      primaryColorDark: Color(0xFFFF9A00),
      primaryColorLight: Color(0xFFFFFFFF),
      iconTheme: IconThemeData(color: Color(0xFFEEEEE)),
      accentColor: Color(0xFF2C2C2C),
      fontFamily: 'Raleway');
  static ThemeData popTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color(0xFF4056A1),
      primaryColorDark: Color(0xFFD79922),
      primaryColorLight: Color(0xFFEFE2BA),
      accentColor: Color(0xFFF13C20),
      iconTheme: IconThemeData(color: Color(0xFFC5CBE3)),
      fontFamily: 'Raleway');
  static ThemeData romanticTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color(0xFFE22945),
      primaryColorDark: Color(0xFFC32F12),
      primaryColorLight: Color(0xFFFD432E),
      accentColor: Color(0xFF414952),
      iconTheme: IconThemeData(color: Color(0xFFF172A1)),
      fontFamily: 'Raleway');
}
