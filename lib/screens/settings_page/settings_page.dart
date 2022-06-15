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
          color: Color(0xff2d2d2d),
        ),
        elevation: 0,
        title: Text(
          "SETTİNGS",
          style: TextStyle(
              color: Color(0xff2d2d2d),
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
      body: Container(),
    );
  }
}
