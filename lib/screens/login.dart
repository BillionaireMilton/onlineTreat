import '../screens/registration.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/roleLog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../screens/mainpage.dart';
import 'package:flutter/services.dart';

import 'firstpage.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    //showing progressDialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );

    final User user = (await _auth
            .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      //check error and display message
      Navigator.pop(context);
      showSnackBar("${ex.message}");
      // PlatformException thisEx = ex;
      // showSnackBar(thisEx.message);
    }))
        .user;

    if (user != null) {
      //verify login
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('doctors/${user.uid}');

      userRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        } else {
          _auth.signOut();
          showSnackBar(
              'No record exist for this user. Please create an account');
          Navigator.pop(context);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, LoginPage.id, (route) => false);
          // showSnackBar(
          //     'No record exist for this user. Please create an account');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, FirstPage.id, (route) => false);
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 5),
              child: Column(
                children: [
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
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/lg.png",
                          width: 250,
                          height: 250,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //height: 20,
                    color: Colors.white,
                    child: Text(
                      "Pet Doctors Login",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.pink[900]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(
                                Icons.email,
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        //check network connectivity
                        var connectivityResult =
                            await Connectivity().checkConnectivity();

                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          showSnackBar('No Internet Connectivity');
                          return;
                        }

                        if (!emailController.text.contains('@')) {
                          showSnackBar('Pease enter a valid Email Address');
                          return;
                        }

                        if (passwordController.text.length < 8) {
                          showSnackBar('Please enter a valid Password');

                          return;
                        }

                        login();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink[800],
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RegistrationPage.id, (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50),
                        Text(
                          "Don't have an account yet? Register here",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
