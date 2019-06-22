import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://drive.google.com/file/d/1-1cBeAHbySq3ck9cM3IhddBGy4nBAKGm/view?usp=sharing'),
                ),
              ),
              InkWell(
                onTap: () async {
                  await launch('https://github.com/KumarSunil17');
                },
                child: Wrap(
                  spacing: 8.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/github-logo.png',
                      width: 30.0,
                      height: 30.0,
                    ),
                    Text(
                      'KumarSunil17',
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Text('Flutter Music'),
              Text('Version 1.0'),
              Text('A local music player application made with flutter.'),
              InkWell(
                onTap: () async {
                  await launch('https://github.com/KumarSunil17');
                },
                child: Wrap(
                  spacing: 8.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/github-logo.png',
                      width: 30.0,
                      height: 30.0,
                    ),
                    Text(
                      'KumarSunil17',
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: Constants.getWidth(context),
            height: Constants.getHeight(context) / 7,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            child: Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Copyright  ',
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launch('http://smarttersstudio.com/');
                        },
                      text: 'Smatters\'s Studio',
                      style: TextStyle(color: Colors.pink, fontSize: 16.0)),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
