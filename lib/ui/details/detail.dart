import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/course.dart';
import 'package:tutorial/netowrk/loading_state.dart';
import 'package:tutorial/ui/details/audio_player.dart';
import 'package:tutorial/ui/details/player_widget.dart';
import 'package:tutorial/ui/details/video_player.dart';

BuildContext _context;

class CourseDetail extends StatefulWidget {
  int courseID;
  CourseDetail(this.courseID);

  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<CourseDetail> {
  final course = GetIt.instance<Course>();

  @override
  void initState() {
    super.initState();
    course.getCourse(widget.courseID);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      child: Observer(
        builder: (_) {
          if (course.loadingState == LoadingState.none) {
            return Container();
          } else if (course.loadingState == LoadingState.loading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (course.loadingState == LoadingState.loaded) {
            return Container(
              child: getCompanyItem(course.course),
            );
          } else if (course.loadingState == LoadingState.error) {
            return Container(
              child: Center(
                child: Text(course.courseListError.msg),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Image _headerImage = new Image.asset(
    'assets/pictures/load_image_error.png',
    height: 100,
    width: 100,
  );

  getCompanyItem(Course courses) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        // children: <Widget>[
        //   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180.0,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Center(
                child: _headerImage,
              ),
              height: 180.0,
              width: double.infinity,
              imageUrl: courses.indexImg,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(courses.title,
                    textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Divider(),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Text(
                      "description",
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.5),
                    )),
                getPlayVideo(courses),
                getPlayAudio(courses),
              ],
            ),
          ),
          //   ],
          // ),
          // Divider(),
        ],
      )),

      // onTap: () {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => SubCourseListPage(courses.id)));
      // },
    );
  }
}

Widget getPlayVideo(Course course) {
  if (course.file != null && course.file.type == "video") {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          elevation: 2,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Image.asset(
                  'assets/pictures/ic_play_video.png',
                  height: 30,
                  width: 30,
                ),
              ),
              Text("Play video")
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            _context,
            MaterialPageRoute(
                builder: (context) => VideoPlayer(
                      path: course.file.url,
                      title: course.title,
                    )));
      },
    );
  } else {
    return Container();
  }
}

Widget getPlayAudio(Course course) {
  if (course.file != null && course.file.type == "voice") {
    return InkWell(
      child: Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        elevation: 2,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: Image.asset(
                'assets/pictures/ic_play_audio.png',
                height: 30,
                width: 30,
              ),
            ),
            Text("Play audio"),
            
          ],
        ),
      ),),
       onTap: () {
        Navigator.push(
            _context,
            MaterialPageRoute(
                builder: (context) => AudioApp(
                      path: course.file.url,
                      title: course.title,
                    )));
      },
    );
  } else {
    return Container();
  }
}

Widget getItemNotFount() {
  return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 15, right: 15),
      alignment: Alignment.center,
      child: Text(
        "sdfa",
        style: TextStyle(fontSize: 14.0),
        textAlign: TextAlign.right,
      ));
}
