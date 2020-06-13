import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:uitask/helpers/AppearAnimation.dart';
import 'package:uitask/screens/listDetails.dart';

class LoginPage extends StatefulWidget {
  String title;

  LoginPage({String title}) {
    this.title = title;
  }

  @override
  State<StatefulWidget> createState() {
    return _LoginState(title);
  }
}

class _LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  String title;

  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  _LoginState(String text) {
    this.title = text;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    TextStyle headings = Theme.of(context).primaryTextTheme.headline5;

    TextStyle subheadings = Theme.of(context).primaryTextTheme.subtitle2;
    TextStyle buttons = Theme.of(context).primaryTextTheme.headline6;

    Color primaryColor = Theme.of(context).primaryColor;

    int delayTime = 500;
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: AppearAnimation(
                delay: delayTime,
                child: AvatarGlow(
                  glowColor: Colors.lightGreen,
                  duration: Duration(milliseconds: 2000),
                  endRadius: 90.0,
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 50,
                      child: FlutterLogo(
                        size: 50,
                      ),
                    ),
                  ))),
            ),
            SizedBox(
              height: 50.0,
            ),
            AppearAnimation(
              child: Text("Welcome to UI Designs Test", style: headings),
              delay: delayTime,
            ),
            AppearAnimation(
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 55, right: 55),
                child: Text(
                    "This is a simple application to check "
                    "the layouts and the animations provided by Flutter"
                    " and Dart",
                    textAlign: TextAlign.center,
                    style: subheadings),
              ),
              delay: delayTime + 500,
            ),
            SizedBox(
              height: 40.0,
            ),
            AppearAnimation(
              child: GestureDetector(
                  onTap: () {
                    navigateToDetail();
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: primaryColor),
                    child: Center(
                      child: Text(
                        'Proceed',
                        style: buttons,
                      ),
                    ),
                  )),
              delay: delayTime + 900,
            ),
            SizedBox(
              height: 30.0,
            ),
            AppearAnimation(
              child: GestureDetector(
                child: Text(
                  "I DON'T WANT TO PROCEED",
                  style: buttons,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Exit'),
                            content:
                                Text('Do you want to exit the Application?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('No'),
                              ),
                              FlatButton(
                                onPressed: () => exit(0),
                                child: Text('Yes'),
                              )
                            ],
                          ));
                },
              ),
              delay: delayTime + 1200,
            ),
            SizedBox(
              height: 30.0,
            ),
            AppearAnimation(
              child: Text("Designed By Swarup", style: subheadings),
              delay: delayTime + 1600,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void navigateToDetail() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListDetails();
    }));
  }
}
