import 'package:cab_driver/screens/registration.dart';
import 'package:cab_driver/widgets/ProgressDialog.dart';
import 'package:cab_driver/widgets/TaxiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cab_driver/screens/roleLog.dart';
import 'package:cab_driver/screens/roleReg.dart';
import 'package:cab_driver/brand_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cab_driver/screens/mainpage.dart';
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
            padding: const EdgeInsets.only(bottom: 20.0),
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
                      width: 400,
                      height: 400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: .2,
            minChildSize: .2,
            maxChildSize: .2,
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
                    SizedBox(height: 20),
                    Text(
                      "Login or Register",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RoleLogPage.id, (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink[800],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15, right: 22, left: 22, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RoleRegPage.id, (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink[800],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15, right: 15, left: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
