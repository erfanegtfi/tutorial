import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/course.dart';
import 'package:tutorial/model/sub_course.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/netowrk/loading_state.dart';
import 'package:tutorial/shared/styles/constants.dart';
import 'package:tutorial/ui/details/detail.dart';
import 'package:tutorial/ui/details/detail_page.dart';
import 'package:tutorial/ui/subCourse/sub_course_list_page.dart';
import 'package:tutorial/widgets/widgets.dart';

class SubCourseList extends StatefulWidget {
  int courseID;
  SubCourseList(this.courseID);

  @override
  State<StatefulWidget> createState() {
    return SubCourseListState();
  }
}

class SubCourseListState extends State<SubCourseList> {
  ScrollController controller;
  int _scrollThreshold = 400;
  bool isLoading;

  final course = GetIt.instance<SubCourse>();

  @override
  void initState() {
    super.initState();
    course.getCourseList(widget.courseID);
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
          } else
            return Container();
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

  Widget _buildCompanyItem(List<SubCourse> courses, int index) {
    if (courses.length > index && courses.elementAt(index).listLoading) //
      return Widgets.listLoadMoreBottom();
    else if (courses.length > index) return getCompanyItem(courses, index);
  }

  getCompanyItem(List<SubCourse> courses, int index) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 1.0,
        child: Container(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  height: 90.0,
                  width: 110.0,
                  fit: BoxFit.cover,
                  imageUrl: courses[index].indexImg,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(courses[index].title,
                            textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: new Text(
                              courses[index].title,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, height: 1.5),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.green,
                              size: 24.0,
                            ),
                            Text("Courses:  ${courses[index].courseUserCount.toString()}")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Divider(),
          ],
        )),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsPage(//InterviewsPage
            courses[index].id)));
      },
    );
  }

  void _scrollListener() {
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.position.pixels;
    // print("BlocBuilder BlocBuilder ${maxScroll} - ${currentScroll} - ${controller.offset}");
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (!isLoading && course.courseList.length % Constants.PAGINATION == 1) {
        isLoading = true;
        // course.getCourseList();
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
