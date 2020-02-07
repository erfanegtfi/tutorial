import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText => duration != null ? duration.toString().split('.').first : '';
  get positionText => position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play() async {
    await audioPlayer.play(widget.path);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    final bytes =
        await _loadFileBytes(widget.path, onError: (Exception exception) => print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
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
                    new Material(child: _buildPlayer()),

                    // localFilePath != null ? new Text(localFilePath) : new Container(),
                    // Container(
                    //   margin: EdgeInsets.only(top: 30),
                    //   height: 200,
                    //   child: WaveWidget(
                    //     config: CustomConfig(
                    //       gradients: [
                    //         [Colors.red, Color(0xEEF44336)],
                    //         [Colors.red[800], Color(0x77E57373)],
                    //         [Colors.orange, Color(0x66FF9800)],
                    //         [Colors.yellow, Color(0x55FFEB3B)]
                    //       ],
                    //       durations: [35000, 19440, 10800, 6000],
                    //       heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    //       gradientBegin: Alignment.bottomLeft,
                    //       gradientEnd: Alignment.topRight,
                    //     ),
                    //     waveAmplitude: 2,
                    //     backgroundColor: Colors.white,
                    //     size: Size(
                    //       double.infinity,
                    //       double.infinity,
                    //     ),
                    //   ),
                    // )
                  ]),
            )));
  }

  Widget _buildPlayer() => new Container(
      color: Colors.white,
      padding: new EdgeInsets.only(top: 50.0),
      child: new Column(mainAxisSize: MainAxisSize.min, children: [
        new Row(mainAxisSize: MainAxisSize.min, children: [
          new IconButton(
              onPressed: isPlaying ? null : () => play(),
              iconSize: 64.0,
              icon: new Icon(Icons.play_arrow),
              color: Colors.cyan),
          new IconButton(
              onPressed: isPlaying ? () => pause() : null,
              iconSize: 64.0,
              icon: new Icon(Icons.pause),
              color: Colors.cyan),
          new IconButton(
              onPressed: isPlaying || isPaused ? () => stop() : null,
              iconSize: 64.0,
              icon: new Icon(Icons.stop),
              color: Colors.cyan),
        ]),
        duration == null
            ? new Container()
            : new Slider(
                value: position?.inMilliseconds?.toDouble() ?? 0.0,
                onChanged: (double value) => audioPlayer.seek((value / 1000).roundToDouble()),
                min: 0.0,
                max: duration.inMilliseconds.toDouble()),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(position != null ? "${positionText ?? ''}" : duration != null ? durationText : '',
                  style: new TextStyle(fontSize: 16.0)),
              new Text(position != null ? "${durationText ?? ''}" : duration != null ? durationText : '',
                  style: new TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        // new Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     new IconButton(onPressed: () => mute(true), icon: new Icon(Icons.headset_off), color: Colors.cyan),
        //     new IconButton(onPressed: () => mute(false), icon: new Icon(Icons.headset), color: Colors.cyan),
        //   ],
        // ),
      ]));
}
