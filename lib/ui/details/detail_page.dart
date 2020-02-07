import 'package:flutter/material.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/ui/details/detail.dart';

class CourseDetailsPage extends StatefulWidget {
  int courseID;
  CourseDetailsPage(this.courseID);

  @override
  State<StatefulWidget> createState() {
    return CourseDetailsPageState();
  }
}

class CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Course Details",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      )),
      body: Container(child: CourseDetail(widget.courseID)),
    );
  }
}
