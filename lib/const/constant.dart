import 'package:flutter/material.dart';

//colors

Color primaryColor = Color(0xff2d2d2d);

TextStyle detailsTitleTextStyle = TextStyle(color: Colors.black45);

BoxDecoration detailsContainerDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 10,
    ),
  ],
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  ),
);

double getWidth(context, x) => MediaQuery.of(context).size.width * x;

double getHeight(context, x) => MediaQuery.of(context).size.height * x;
