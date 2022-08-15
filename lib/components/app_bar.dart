import 'package:book_tracking/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

AppBar appbarBuild(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: Icon(
      Icons.menu,
      color: primaryColor,
    ),
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
          color: primaryColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
    ),
  );
}
