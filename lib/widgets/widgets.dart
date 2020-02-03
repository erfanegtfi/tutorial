import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Widgets {
  static Widget getItemError() {
    return Container(
        margin: EdgeInsets.only(top: 6, bottom: 6, left: 15, right: 15),
        alignment: Alignment.center,
        child: Text(
          "مشکلی رخ داد!",
          style: TextStyle(fontSize: 14.0),
          textAlign: TextAlign.right,
        ));
  }

  static Widget listLoadMoreBottom() {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
