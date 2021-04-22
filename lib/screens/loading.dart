import 'dart:async';
import '../datamodels/doctor.dart';
import '../globalvaribles.dart';
import '../helpers/helpermethods.dart';
import '../screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  static const String id = 'loading';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    //getCurrentDoctorInfo();
    Timer(
        Duration(seconds: 10),
        () => Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Uploading your informations... ",
                          style: TextStyle(fontSize: 35.0, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
