import 'package:book_tracking/components/app_bar.dart';
import 'package:book_tracking/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild("SETTİNGS"),
      body: Container(),
    );
  }
}
