import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/course.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/netowrk/loading_state.dart';
import 'package:tutorial/shared/styles/constants.dart';
import 'package:tutorial/ui/subCourse/sub_course_list_page.dart';
import 'package:tutorial/widgets/widgets.dart';

class CourseList extends StatefulWidget {
  CourseList();

  @override
  State<StatefulWidget> createState() {
    return CourseListState();
  }
}

class CourseListState extends State<CourseList> {
  ScrollController controller;
  int _scrollThreshold = 400;
  bool isLoading;

  final course = GetIt.instance<Course>();

  @override
  void initState() {
    super.initState();
    course.getCourseList();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            isLoading = false;
            if (course.courseList.length == 0)
              return Widgets.noItemFoundCourse("No course found!");
            else
              return Container(
                  child: ListView.builder(
                itemCount: course.courseList.length,
                itemBuilder: (context, index) => _buildCompanyItem(course.courseList, index),
                controller: controller,
              ));
          } else if (course.loadingState == LoadingState.error) {
            return Text(course.courseListError.toString());
          } else {
            return Container();
          }
        },
      ),
    );

    // return Container(
    //   child: Observer(
    //     builder: (_) {
    //       if (course.state is InitialState) {
    //         return Container();
    //       } else if (course.state is LoadingState) {
    //         return Container(
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       } else if (course.state is LoadedState) {
    //         LoadedState state = course.state as LoadedState;
    //         isLoading = false;
    //         return Container(
    //             child: ListView.builder(
    //           itemCount: state.objects.length,
    //           itemBuilder: (context, index) => _buildCompanyItem(state, index),
    //           controller: controller,
    //         ));
    //       }
    //     },
    //   ),
    // );

    // return Directionality(
    // textDirection: TextDirection.rtl,
    // child: BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
    //   if (state is CompanyInitial)
    //     return Container(width: 0.0, height: 0.0);
    //   else if (state is CompanyLoading)
    //     return Container(
    //       child: Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     );
    //   else if (state is CompanyListLoaded) {
    //     isLoading = false;
    //     companyLoaded = state;
    //     return
    //         // NotificationListener<ScrollNotification>(
    //         //     onNotification: _handleScrollNotification,
    //         //     child:
    //         Container(
    //             child: ListView.builder(
    //       itemCount: companyLoaded.companies.length,
    //       itemBuilder: (context, index) => _buildCompanyItem(state, index),
    //       controller: controller,
    //     ));
    //   } else if (state is CompanyFailure) {
    //     return Widgets.getItemError();
    //   } else if (state is CompanyEmptyList)
    //     return getItemNotFount();
    //   else
    //     return Container(width: 0.0, height: 0.0);
    // }));
  }

  Widget _buildCompanyItem(List<Course> courses, int index) {
    if (courses.length > index && courses.elementAt(index).listLoading) //
      return Widgets.listLoadMoreBottom();
    else if (courses.length > index) return getCompanyItem(courses, index);
  }

  Image _headerImage = new Image.asset(
    'assets/pictures/load_image_error.png',
    height: 100,
    width: 100,
  );

  getCompanyItem(List<Course> courses, int index) {
    return GestureDetector(
      child: Card(
        elevation: 1.0,
        child: Container(
            child: Column(
          // children: <Widget>[
          //   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Center(
                    child: _headerImage,
                  ),
                  height: 220.0,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  imageUrl: courses[index].indexImg,
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white, borderRadius: new BorderRadius.all(const Radius.circular(25.0))),
                        margin: EdgeInsets.all(10),
                        child: Text("Courses:  ${courses[index].courseUserCount.toString()}"),
                      )),
                ),
              ],
            ),
            // Expanded(
            //   child:
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(courses[index].title,
                        textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new Text(
                          courses[index].description,
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, height: 1.5),
                        )),
                  ],
                )),

            // ),
            //   ],
            // ),
            // Divider(),
          ],
        )),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SubCourseListPage(courses[index].id)));
      },
    );
  }

  void _scrollListener() {
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (!isLoading && course.courseList[course.courseList.length - 1].listLoading) {
        isLoading = true;
        course.getCourseList();
      }
    }
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
