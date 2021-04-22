import 'dart:io';
import '../screens/doctorinfo.dart';
import '../screens/loading.dart';
import '../screens/tecinfo.dart';
import '../widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
import '../brand_colors.dart';
import '../globalvaribles.dart';
import '../screens/mainpage.dart';
import '../widgets/TaxiButton.dart';
import '../widgets/ComingSoon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Latest extends StatefulWidget {
  static const String id = 'latest';

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
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

  String doctorImageUrl;

  void updateProfile(context) async {
    await _uploadImage();
    await _uploadImage();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Uploading Your picture...',
      ),
    );

    print('image upload');

    String id = currentFirebaseUser.uid;
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm a');

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();

    DatabaseReference doctorRef =
        FirebaseDatabase.instance.reference().child('doctors/$id/doctor_info');

    Map<String, dynamic> map = {
      'imageUrl': doctorImageUrl,
      'date': date,
      'time': time,
    };

    await doctorRef.update(map);

    if (currentDoctorInfo.role == "Doctor") {
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }

  // files required in the form
  File _imageFile;
  String imageName;
  ImagePicker imagePicker = ImagePicker();

  // Choose profile image function
  Future<void> _choosedImage() async {
    File pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _imageFile = File(pickedFile.path);
      imageName =
          "petambulance profile picture.${_imageFile.path.split('.').last}";
    });
  }

  // Upload profile pic
  Future<void> _uploadImage() async {
    // Create a unique filename for image
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${currentDoctorInfo.email}/Images')
        .child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) async {
        // Save to real time database
        //updateProfile(imageUrl);
        setState(() async {
          doctorImageUrl = imageUrl;
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
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 45.0,
            top: 8.0,
            right: 15.0,
            left: 15.0,
          ),
          child: TaxiButton(
            color: Colors.pink[900],
            title: 'Proceed',
            onPressed: () {
              if (imageName == null) {
                showSnackBar('please choose a profile picture ');
                return;
              }

              print('first show dialog');

              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => ProgressDialog(
                  status: 'Uploading Your Picture...',
                ),
              );

              // _uploadImage();
              print('update profile init');
              updateProfile(context);

              //comingSoon(context);
              // updateProfile(context);
            },
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
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
                ],
              ),
              _imageFile == null
                  ? Image.asset(
                      'images/user_icon.png',
                      height: 210,
                      width: 210,
                    )
                  : //Image.file(_imageFile),
                  Container(
                      width: double.infinity,
                      height: 300,
                      alignment: Alignment(0.0, 0.0),
                      child: CircleAvatar(
                        backgroundImage: FileImage(_imageFile),
                        radius: 150.0,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Text(
                      "Upload Profile Image",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.pink[900]),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          _choosedImage();
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
                                  Icons.image,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _imageFile == null
                                      ? "Tap to upload profile picture"
                                      : '${imageName}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
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
                      child: Text('you can change this later on your profile',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                          )),
                    ),
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
