import 'dart:async';
import '../datamodels/doctor.dart';
import '../globalvaribles.dart';
import '../screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'homesplash';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  void getCurrentDoctorInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    DatabaseReference doctorRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}');
    doctorRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentDoctorInfo = Doctor.fromSnapshot(snapshot);
        print('my name is ${currentDoctorInfo.fullName}');
        print('this is data list ${currentDoctorInfo}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentDoctorInfo();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("images/lg.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Pet Ambulance",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
