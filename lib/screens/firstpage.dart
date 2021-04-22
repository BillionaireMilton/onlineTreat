import '../screens/login.dart';
import '../screens/registration.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/roleLog.dart';
import '../screens/roleReg.dart';
import '../brand_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../screens/mainpage.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  static const String id = 'first';

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Image.asset(
              "images/bg.jpg",
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      "images/lg.png",
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: .3,
            minChildSize: .25,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          offset: Offset(2, 3),
                          blurRadius: 12)
                    ]),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            LoginPage.id,
                                            (route) => false);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.pink[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 30,
                                              right: 57,
                                              left: 57,
                                              bottom: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Login",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            RegistrationPage.id,
                                            (route) => false);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.pink[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 30,
                                              right: 50,
                                              left: 50,
                                              bottom: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Register",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
