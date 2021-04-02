import 'dart:async';
import 'package:cab_driver/datamodels/doctor.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/helpers/helpermethods.dart';
import 'package:cab_driver/helpers/pushnotificationservice.dart';
import 'package:cab_driver/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  static const String id = 'loading';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<Loading> {
  // void getCurrentDoctorInfo() async {
  //   currentFirebaseUser = FirebaseAuth.instance.currentUser;
  //   DatabaseReference doctorRef = FirebaseDatabase.instance
  //       .reference()
  //       .child('doctors/${currentFirebaseUser.uid}');
  //   doctorRef.once().then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       currentDoctorInfo = Doctor.fromSnapshot(snapshot);
  //       print('my name is ${currentDoctorInfo.fullName}');
  //       print('this is data list ${currentDoctorInfo}');
  //     }
  //   });
  //   PushNotificationService pushNotificationService = PushNotificationService();

  //   pushNotificationService.initialize(context);
  //   pushNotificationService.getToken();

  //   HelperMethods.getHistoryInfo(context);
  // }

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
