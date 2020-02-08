import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial/shared/audioplayer.dart';
import 'package:tutorial/ui/details/player_widget.dart';

class AudioApp extends StatefulWidget {

  final String title;
  final String path;

  AudioApp({this.path, this.title});

  @override
  _AudioAppState createState() => new _AudioAppState();
}

enum PlayerState { stopped, playing, paused }
typedef void OnError(Exception exception);

// const kUrl = "http://dls.music-fa.com/tagdl/downloads/Milad%20Ghorbani%20-%20Shalvar%20Palangi%20(128).mp3";

class _AudioAppState extends State<AudioApp> {
  Duration duration;
  Duration position;


  String localFilePath;


  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  Image _headerImage = new Image.asset(
    'assets/pictures/wave.jpg',
    width: double.infinity,
  );

  Image _logoImage = new Image.asset(
    'assets/pictures/play_gram.png',
    height: 100,
    width: 100,
  );
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Material(
            color: Colors.white,
            elevation: 2.0,
            child: new Center(
              child: new Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 30),
                          child: _headerImage,
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: _logoImage,
                              )),
                        ),
                      ],
                    ),
                   PlayerWidget(url: widget.path),

                   
                  ]),
            )));
  }
}
