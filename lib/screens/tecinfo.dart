import 'dart:io';
import '../screens/loading.dart';
import '../widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
import '../brand_colors.dart';
import '../globalvaribles.dart';
import '../screens/mainpage.dart';
import '../widgets/TaxiButton.dart';
import '../widgets/ComingSoon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../screens/profilePic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TecInfoPage extends StatefulWidget {
  static const String id = 'tecinfo';

  @override
  _TecInfoPageState createState() => _TecInfoPageState();
}

class _TecInfoPageState extends State<TecInfoPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime slectedGrad;
  String gradDate;
  DateTime slectedDob;
  String dobDate;
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

  String doctorMemCertUrl;
  String doctorIdentUrl;
  String doctorCertUrl;

  Future<void> _slectedGrad(BuildContext context) async {
    slectedGrad = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: slectedGrad,
        firstDate: DateTime(1947),
        lastDate: DateTime.now(),
        //textDirection: TextDirection.ltr,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.green,
              primaryColor: Colors.green,
              accentColor: Colors.green,
            ),
            child: child,
          );
        });

    if (picked != null && picked != slectedGrad) {
      setState(() {
        slectedGrad = picked;
        gradDate = "${slectedGrad.toString()}".split(' ')[0];
      });
    }
  }

  Future<void> _slectedDob(BuildContext context) async {
    slectedDob = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: slectedDob,
        firstDate: DateTime(1947),
        lastDate: DateTime.now(),
        //textDirection: TextDirection.ltr,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.green,
              primaryColor: Colors.green,
              accentColor: Colors.green,
            ),
            child: child,
          );
        });

    if (picked != null && picked != slectedDob) {
      setState(() {
        slectedDob = picked;
        dobDate = "${slectedDob.toString()}".split(' ')[0];
      });
    }
  }

  void updateProfile(context) async {
    await _uploadMemCert();
    await _uploadCert();
    await _uploadIdent();
    await _uploadCert();
    print('ident upload');
    print('update profile func called');
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Uploading Your documents...',
      ),
    );
    // await _uploadCert();
    // print('cert upload');
    // await _uploadMemCert();
    print('image upload');
    // await _uploadIdent();
    // print('ident upload');

    String id = currentFirebaseUser.uid;
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm a');

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();

    DatabaseReference doctorRef =
        FirebaseDatabase.instance.reference().child('doctors/$id/doctor_info');

    Map<String, dynamic> map = {
      'dob': dobDate,
      'identUrl': doctorIdentUrl,
      'memCertUrl': doctorMemCertUrl,
      'nin': nin.text,
      'address': address.text,
      'university': university.text,
      'yog': gradDate,
      'certUrl': doctorCertUrl,
      'vcn': vcn.text,
      'date': date,
      'time': time,
      'comp': 0,
    };

    await doctorRef.update(map);

    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }

  // files required in the form
  File _memCertFile;
  String memCertName;
  File _identFile;
  String identName;
  File _certFile;
  String certName;

  ImagePicker imagePicker = ImagePicker();

  // Choose profile memCert function
  Future<void> _choosedMemCert() async {
    File pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _memCertFile = File(pickedFile.path);
      memCertName =
          "petambulance NAAHHT cert.${_memCertFile.path.split('.').last}";
    });
  }

  // Choose identification file function
  Future<void> _choosedIdent() async {
    File pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _identFile = File(pickedFile.path);
      identName =
          "petambulance identity file.${_identFile.path.split('.').last}";
    });
  }

  // Choose certificate image function
  Future<void> _choosedCert() async {
    File pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _certFile = File(pickedFile.path);
      certName =
          "petambulance certificate file.${_certFile.path.split('.').last}";
    });
  }

  // Upload profile pic
  Future<void> _uploadMemCert() async {
    // Create a unique filename for memCert
    String memCertFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${currentDoctorInfo.email}/MemCerts')
        .child(memCertFileName);
    final UploadTask uploadTask = storageReference.putFile(_memCertFile);
    await uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // Save to real time database
        //updateProfile(imageUrl);
        setState(() {
          doctorMemCertUrl = imageUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }

  // Upload identity file
  Future<void> _uploadIdent() async {
    // Create a unique filename for image
    String identFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${currentDoctorInfo.email}/Identifications')
        .child(identFileName);
    final UploadTask uploadTask = storageReference.putFile(_identFile);
    await uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // Save to real time database
        //updateProfile(identUrl);
        setState(() {
          doctorIdentUrl = imageUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }

  // Upload identity file
  Future<void> _uploadCert() async {
    // Create a unique filename for image
    String certFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${currentDoctorInfo.email}/Certificates')
        .child(certFileName);
    final UploadTask uploadTask = storageReference.putFile(_certFile);
    await uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // Save to real time database
        //updateProfile(certUrl);
        setState(() {
          doctorCertUrl = imageUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Update your Informations",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.pink[900]),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    // NAAHHT MEMBERSHIP FIELD
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 4),
                      child: GestureDetector(
                        onTap: () async {
                          _choosedMemCert();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.pink[800],
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15, right: 10, left: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  (FontAwesome.certificate),
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _memCertFile == null
                                      ? "Tap to upload NAAHHT membership certificate"
                                      : '${memCertName}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // IDENTIFICATION FIELD
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 4),
                      child: GestureDetector(
                        onTap: () async {
                          _choosedIdent();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.pink[800],
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15, right: 15, left: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  (FontAwesome.id_card),
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _identFile == null
                                      ? "Tap to upload means of identification"
                                      : '${identName}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 6),
                      child: Text(
                          'voters card / drivers lincence / national identity card / international passport',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                          )),
                    ),

                    // DOB INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _slectedDob(context);
                              });
                            },
                            controller: dob,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: dobDate == null
                                    ? "Date of Birth"
                                    : 'Date of Birth: ${dobDate}',
                                hintText: dobDate == null
                                    ? "Tap to select your date of birth"
                                    : '${dobDate}',
                                icon: Icon(
                                  FontAwesome.calendar,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // NIN INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: nin,
                            keyboardType: TextInputType.number,
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
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
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
                                labelText: "Address",
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
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
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
                                labelText: "Your Institution",
                                hintText: "College / polytechnic / university",
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
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _slectedGrad(context);
                              });
                            },
                            controller: yog,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: gradDate == null
                                    ? "Year of Graduation"
                                    : 'Year of graduation: ${gradDate}',
                                hintText: gradDate == null
                                    ? "Tap to select year of graduation"
                                    : '${gradDate}',
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
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          _choosedCert();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.pink[800],
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15, right: 15, left: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  (FontAwesome.id_card),
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _certFile == null
                                      ? "Tap to upload certification"
                                      : '${certName}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 6),
                      child: Text(
                          'Animal health tech certificate or other professional certification',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                          )),
                    ),

                    // VCN INPUT FIELD
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
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
                                  (MaterialIcons.format_list_numbered),
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    TaxiButton(
                        color: Colors.pink[900],
                        title: 'Update',
                        onPressed: () {
                          if (memCertName == null) {
                            showSnackBar(
                                'please kindly upload your NAAHHT membership certificate');
                            return;
                          }

                          if (nin.text.length < 11) {
                            showSnackBar('Please provide a valid NIN');
                            return;
                          }

                          if (identName == null) {
                            showSnackBar(
                                'please upload a means of identification ');
                            return;
                          }

                          if (certName == null) {
                            showSnackBar(
                                'please kindly upload your certificate');
                            return;
                          }
                          if (gradDate == null) {
                            showSnackBar('kindly input your graduation date');
                            return;
                          }
                          if (dobDate == null) {
                            showSnackBar('kindly input your date of birth');
                            return;
                          }
                          if (vcn.text.length < 3) {
                            showSnackBar('Please provide a valid VCN');
                            return;
                          }

                          if (address.text.length < 3) {
                            showSnackBar('Please enter your address');
                            return;
                          }

                          if (university.text.length < 3) {
                            showSnackBar('Please input your institution name');
                            return;
                          }

                          print('first show dialog');

                          // showDialog(
                          //   barrierDismissible: false,
                          //   context: context,
                          //   builder: (BuildContext context) => ProgressDialog(
                          //     status: 'Uploading Your documents...',
                          //   ),
                          // );

                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => ProgressDialog(
                              status: 'This might take a while...',
                            ),
                          );

                          print('update profile init');
                          updateProfile(context);

                          //comingSoon(context);
                          // updateProfile(context);
                        }),
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
