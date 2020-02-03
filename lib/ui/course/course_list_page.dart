import 'package:flutter/material.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/ui/course/course_list.dart';

class CourseListPage extends StatefulWidget {
  CourseListPage();

  @override
  State<StatefulWidget> createState() {
    return CourseListPageState();
  }
}

class CourseListPageState extends State<CourseListPage> {
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
      body: Container(child: CourseList()),
    );
  }
}
