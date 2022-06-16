import 'package:book_tracking/const/constant.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: primaryColor,
        ),
        elevation: 0,
        title: Text(
          "SETTİNGS",
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Container(),
    );
  }
}
