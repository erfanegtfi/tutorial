import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  VideoPlayer({this.path, this.title});

  final String title;
  final String path;
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // getvideo().then((onVal) {
    //   _videoPlayerController1 = VideoPlayerController.file(onVal);
    //   print(onVal.uri);

    //   _chewieController = ChewieController(
    //     videoPlayerController: _videoPlayerController1,
    //     aspectRatio: 3 / 2,
    //     autoPlay: true,
    //     looping: true,
    //   );
    //   setState(() {
    //     print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    //   });
    // });

    _videoPlayerController1 = VideoPlayerController.network(
        widget.path);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // allowFullScreen: false
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    _chewieController.enterFullScreen();
  }

  Future<File> getvideo() async {
    File file = await DefaultCacheManager().getSingleFile(
        'https://as2.cdn.asset.aparat.com/aparat-video/27122ae2ab477a92779d7be533a66e1819253862-360p__48288.mp4');
    return file;
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  if (_chewieController==null) {
    //              return MaterialApp(
    //   title: widget.title,
    //   theme: ThemeData.light().copyWith(
    //     platform: _platform ?? Theme.of(context).platform,
    //   ),
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text(widget.title),
    //     ),
    //     body: Column(
    //       children: <Widget>[
    //         Expanded(

    //           child: Center(
    //             child: CircularProgressIndicator()
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    //           }else{
    return Scaffold(
       
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ],
        ),
      
    );
    // }
  }
}
