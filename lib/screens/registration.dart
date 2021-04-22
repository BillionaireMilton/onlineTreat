import '../globalvaribles.dart';
import '../screens/login.dart';
import '../screens/mainpage.dart';
import '../widgets/ProgressDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

import 'firstpage.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var cpasswordController = TextEditingController();

  String gender;
  String role;

  List _genderList = [
    'Male',
    'Female',
  ];

  List _roleList = [
    'Doctor',
    'Animal Health Technologist',
  ];

  void registerUser() async {
    //show please wait dialog

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Registering you in',
      ),
    );

    final User user = (await _auth
            .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;

      showSnackBar(thisEx.message);
    }))
        .user;

    Navigator.pop(context);

    if (user != null) {
      var dateFormat = DateFormat('MMM d, yyyy');
      var timeFormat = DateFormat('EEEE, hh:mm a');

      String date = dateFormat.format(DateTime.now()).toString();
      String time = timeFormat.format(DateTime.now()).toString();
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('doctors/${user.uid}');

      Map userMap = {
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'gender': gender,
        'date': date,
        'time': time,
      };

      newUserRef.set(userMap);

      currentFirebaseUser = user;

      DatabaseReference doctorRef = FirebaseDatabase.instance
          .reference()
          .child('doctors/${user.uid}/doctor_info');

      Map map = {
        'role': role,
        'prof': null,
        'comp': null,
        'pfl': null,
        'imageUrl': null,
        'dob': null,
        'identUrl': null,
        'nin': null,
        'address': null,
        'university': null,
        'yog': null,
        'certUrl': null,
        'vcn': null,
        'date': null,
        'time': null,
      };

      doctorRef.set(map);

      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 0,
              ),
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
                      width: 210,
                      height: 210,
                    ),
                  ],
                ),
              ),
              Container(
                //height: 20,
                color: Colors.white,
                child: Text(
                  "Pet Doctors Registration",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.pink[900]),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // NAME INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.green),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.green),
                          labelText: "Name",
                          hintText: "eg: Milton Jes",
                          icon: Icon(
                            Icons.person,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ),

              // EMAIL INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
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
                          labelStyle: TextStyle(color: Colors.green),
                          labelText: "Email",
                          hintText: "mint@proloxy.com",
                          icon: Icon(
                            Icons.email,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ),

              // GENDER INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, right: 35),
                    child: DropdownButton(
                      hint: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.green),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  MaterialIcons.people,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextSpan(text: 'Select your gender'),
                          ],
                        ),
                      ),
                      dropdownColor: Colors.white,
                      elevation: 5,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green,
                      ),
                      iconSize: 36.0,
                      isExpanded: true,
                      underline: Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      value: gender,
                      style: TextStyle(color: Colors.green, fontSize: 22.0),
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      items: _genderList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // PHONE INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.green),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.green),
                          labelText: "Phone",
                          hintText: "+91 3213452",
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ),

              // ROLE INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, right: 35),
                    child: DropdownButton(
                      hint: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.green),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  FontAwesome.hospital_o,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextSpan(text: 'Select your role'),
                          ],
                        ),
                      ),
                      dropdownColor: Colors.white,
                      elevation: 5,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green,
                      ),
                      iconSize: 36.0,
                      isExpanded: true,
                      underline: Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      value: role,
                      style: TextStyle(color: Colors.green, fontSize: 22.0),
                      onChanged: (value) {
                        setState(() {
                          role = value;
                        });
                      },
                      items: _roleList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // PASWORD INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.green),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.green),
                          labelText: "Password",
                          hintText: "at least 6 digits",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ),

              // CONFIRM PASWORD INPUT FIELD
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: cpasswordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.green),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.green),
                          labelText: "Confirm Password",
                          hintText: "thesame with password above",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    //Check network availability

                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      showSnackBar('No internet connectivity');
                      return;
                    }

                    //full name
                    if (fullNameController.text.length < 3) {
                      showSnackBar('Please provide a valid fullname');
                      return;
                    }

                    //phone number
                    if (phoneController.text.length < 10) {
                      showSnackBar('Please provide a valid phone number');
                      return;
                    }

                    //gender name
                    if (gender == null) {
                      showSnackBar('please select gender');
                      return;
                    }

                    //role name
                    if (role == null) {
                      showSnackBar('please select your role');
                      return;
                    }

                    //email address
                    if (!emailController.text.contains('@')) {
                      showSnackBar('Please provide a valid email address');
                      return;
                    }

                    //password
                    if (passwordController.text.length < 8) {
                      showSnackBar('password must be at least 8 characters');
                      return;
                    }

                    //Confirm password
                    if (passwordController.text != cpasswordController.text) {
                      showSnackBar("Password does'nt match");
                      return;
                    }

                    registerUser();
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.id, (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      "Already registered? Login here",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
