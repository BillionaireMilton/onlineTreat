import 'dart:io';

import 'package:cab_driver/brand_colors.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/screens/mainpage.dart';
import 'package:cab_driver/widgets/TaxiButton.dart';
import 'package:cab_driver/widgets/ComingSoon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DoctorInfoPage extends StatefulWidget {
  static const String id = 'tecinfo';

  @override
  _DoctorInfoPageState createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
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

  TextEditingController yog = TextEditingController();
  TextEditingController university = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController nin = TextEditingController();
  TextEditingController vcn = TextEditingController();
  TextEditingController address = TextEditingController();

  String tecImageUrl;
  String tecIdentUrl;
  String tecCertUrl;

  void updateProfile(context) {
    String id = currentFirebaseUser.uid;
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm a');

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();

    DatabaseReference tecRef =
        FirebaseDatabase.instance.reference().child('tecs/$id/tec_info');

    Map map = {
      'imageUrl': tecImageUrl,
      'dob': dob.text,
      'identUrl': tecIdentUrl,
      'nin': time,
      'address': time,
      'university': university.text,
      'yog': yog.text,
      'certUrl': tecCertUrl,
      'vcn': time,
      'date': date,
      'time': time,
      'comp': 0,
    };

    tecRef.update(map);

    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }

  // files required in the form
  File _imageFile;
  File _identFile;
  File _certFile;

  ImagePicker imagePicker = ImagePicker();

  // Choose profile image function
  Future<void> _choosedImage() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  // Choose identification file function
  Future<void> _choosedIdent() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _identFile = File(pickedFile.path);
    });
  }

  // Choose certificate image function
  Future<void> _choosedCert() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _certFile = File(pickedFile.path);
    });
  }

  // Upload profile pic
  void _uploadImage() {
    // Create a unique filename for image
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Images').child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(_imageFile);
    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // Save to real time database
        //updateProfile(imageUrl);
        setState(() {
          tecImageUrl = imageUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }

  // Upload identity file
  void _uploadIdent() {
    // Create a unique filename for image
    String identFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Identifications')
        .child(identFileName);
    final UploadTask uploadTask = storageReference.putFile(_identFile);
    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((identUrl) {
        // Save to real time database
        //updateProfile(identUrl);
        setState(() {
          tecIdentUrl = identUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }

  // Upload identity file
  void _uploadCert() {
    // Create a unique filename for image
    String certFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Certificates')
        .child(certFileName);
    final UploadTask uploadTask = storageReference.putFile(_certFile);
    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((certUrl) {
        // Save to real time database
        //updateProfile(certUrl);
        setState(() {
          tecCertUrl = certUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }

  _saveData(imageUrl) {
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm a');

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    void comingSoon(BuildContext context) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => ComingSoonDialog());
    }

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icon(Icons.keyboard_arrow_left),
                      color: Colors.black,
                      onPressed: () {
                        // Navigator.pop(context, 'mainpage');
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainPage.id, (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'images/lg.png',
                height: 210,
                width: 110,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Update your Informations',
                      style: TextStyle(fontFamily: 'Brand- Bold', fontSize: 22),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // PROFILE PIC FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                              labelStyle: TextStyle(color: Colors.green),
                              labelText: "profilePic",
                              hintText: "upload profile pic",
                              icon: Icon(
                                Icons.ballot,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // IDENTIFICATION FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                              labelStyle: TextStyle(color: Colors.green),
                              labelText: "identification",
                              hintText: "upload identification",
                              icon: Icon(
                                Icons.ballot,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // NIN INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: nin,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "NIN",
                                hintText: "Your National Identification Number",
                                icon: Icon(
                                  Icons.confirmation_num,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // ADDRESS INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "address",
                                hintText: "highway canada 27 artkinston",
                                icon: Icon(
                                  Icons.place,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // UNIVERSITY INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: university,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "University",
                                hintText: "Your University",
                                icon: Icon(
                                  Icons.school,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // YOG INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: yog,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "YOG",
                                hintText: "Year of Graduation",
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // CERTIFICATION FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                              labelStyle: TextStyle(color: Colors.green),
                              labelText: "Certification",
                              hintText: "upload certificate",
                              icon: Icon(
                                Icons.ballot,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // VCN INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: vcn,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "VCN",
                                hintText: "Vetinary Certification Number",
                                icon: Icon(
                                  Icons.stay_primary_landscape,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40.0,
                    ),
                    TaxiButton(
                      color: Colors.pink[900],
                      title: 'Update',
                      onPressed: () {
                        if (yog.text.length < 3) {
                          showSnackBar('Please provide a valid NIN');
                          return;
                        }

                        if (university.text.length < 3) {
                          showSnackBar('Please provide a valid VCN');
                          return;
                        }

                        if (dob.text.length < 3) {
                          showSnackBar('Please provide a certification');
                          return;
                        }

                        comingSoon(context);
                        // updateProfile(context);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
