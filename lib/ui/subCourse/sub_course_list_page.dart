import 'package:flutter/material.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/ui/course/course_list.dart';
import 'package:tutorial/ui/subCourse/sub_course_list.dart';

class SubCourseListPage extends StatefulWidget {
  int courseID;
  SubCourseListPage(this.courseID);

  @override
  State<StatefulWidget> createState() {
    return SubCourseListPageState();
  }
}

class SubCourseListPageState extends State<SubCourseListPage> {
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
            AppStrings.courseListTitle,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      )),
      body: Container(child: SubCourseList(widget.courseID)),
    );
  }
}
