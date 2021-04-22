import '../screens/login.dart';
import '../screens/registration.dart';
import '../screens/firstpage.dart';
import '../screens/loginTec.dart';
import '../widgets/TaxiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../brand_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../screens/mainpage.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RoleLogPage extends StatefulWidget {
  static const String id = 'rolelog';

  @override
  _RoleLogPageState createState() => _RoleLogPageState();
}

class _RoleLogPageState extends State<RoleLogPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            top: 0.0,
            right: 8.0,
            left: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    alignment: Alignment.bottomLeft,
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.black,
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, FirstPage.id, (route) => false);
                    },
                  ),
                ],
              ),
              Expanded(
                child: Image.asset(
                  "images/lg.png",
                  width: 300,
                  height: 300,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Log in to Pet Ambulance as ?",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.green),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.id, (route) => false);
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
                            "Pet Doctor",
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
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginTecPage.id, (route) => false);
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
                            "Animal Health Technician",
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
        ),
      ),
    );
  }
}
