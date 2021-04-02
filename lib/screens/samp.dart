// import 'package:cab_driver/screens/mainpage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:volveretask/Output.dart';
// // import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// // import 'package:flutter_colorpicker/block_picker.dart';
// // import 'package:flutter_colorpicker/utils.dart';

// class Home extends StatefulWidget {
//   static const String id = 'Hometest';
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _HomeState();
//   }
// }

// const MaterialColor _buttonTextColor = MaterialColor(0xFFC41A38, <int, Color>{
//   50: Color(0xFFC41A38),
//   100: Color(0xFFC41A38),
//   200: Color(0xFFC41A38),
//   300: Color(0xFFC41A38),
//   400: Color(0xFFC41A38),
//   500: Color(0xFFC41A38),
//   600: Color(0xFFC41A38),
//   700: Color(0xFFC41A38),
//   800: Color(0xFFC41A38),
//   900: Color(0xFFC41A38),
// });

// class _HomeState extends State<Home> {
//   var _state = ["Gujarat", "Punjab", "Haryana", "Bihar", "Other"];
//   var _selectedState;
//   DateTime selectedDate;
//   Color currentColor = Colors.white;

//   void changeColor(Color color) => setState(() => currentColor = color);

//   var _formkey = GlobalKey<FormState>();

//   TextEditingController name_controller = TextEditingController();
//   TextEditingController add_controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     selectedDate = DateTime.now();
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(1947),
//         lastDate: DateTime.now(),
//         textDirection: TextDirection.ltr,
//         initialDatePickerMode: DatePickerMode.day,
//         builder: (BuildContext context, Widget child) {
//           return Theme(
//             data: ThemeData(
//               primarySwatch: _buttonTextColor,
//               primaryColor: Color(0xFFC41A38),
//               accentColor: Color(0xFFC41A38),
//             ),
//             child: child,
//           );
//         });

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//   // void _save() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   preferences.setString("name", name_controller.text);
//   //   preferences.setInt("color", currentColor.value);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = Theme.of(context).textTheme.button;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Data"),
//         leading: IconButton(
//           //alignment: Alignment.bottomLeft,
//           icon: Icon(Icons.keyboard_arrow_left),
//           color: Colors.black,
//           onPressed: () {
//             // Navigator.pop(context);
//             Navigator.pushNamedAndRemoveUntil(
//                 context, MainPage.id, (route) => false);
//           },
//         ),
//       ),
//       body: Form(
//           key: _formkey,
//           //padding: EdgeInsets.only(left: 5.0, right: 5.0),
//           child: Padding(
//             padding: EdgeInsets.only(left: 5.0, right: 5.0),
//             child: ListView(
//               children: <Widget>[
//                 SizedBox(
//                   height: 50.0,
//                 ),
//                 Center(
//                     child: Text(
//                   "Fill The Details",
//                   style: TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 )),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(bottom: 20.0),
//                     child: TextFormField(
//                       style: textStyle,
//                       keyboardType: TextInputType.text,
//                       controller: name_controller,
//                       validator: (String value) {
//                         if (value.isEmpty) {
//                           return "Please Enter Name...";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         labelText: "Name: ",
//                         labelStyle: textStyle,
//                         errorStyle: TextStyle(
//                           color: Color(0xFFC41A38),
//                         ),
//                       ),
//                     )),
//                 Padding(
//                     padding: EdgeInsets.only(bottom: 20.0),
//                     child: TextFormField(
//                       validator: (String value) {
//                         if (value.isEmpty) {
//                           return "Please Enter Address...";
//                         }
//                         return null;
//                       },
//                       style: textStyle,
//                       controller: add_controller,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         labelStyle: textStyle,
//                         errorStyle: TextStyle(
//                           color: Color(0xFFC41A38),
//                         ),
//                         labelText: "Address: ",
//                       ),
//                     )),
//                 Container(
//                   padding: EdgeInsets.only(bottom: 20.0),
//                   child: DropdownButton<String>(
//                     elevation: 10,
//                     hint: Text("Select State"),
//                     value: _selectedState,
//                     style: textStyle,
//                     items: _state.map((String item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     onChanged: (String newitem) {
//                       setState(() {
//                         this._selectedState = newitem;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextFormField(
//                     cursorColor: Color(0xFFC41A38),
//                     readOnly: true,
//                     onTap: () {
//                       setState(() {
//                         _selectDate(context);
//                       });
//                     },
//                     decoration: InputDecoration(
//                         labelText: 'Date of Birth',
//                         hintText: ("${selectedDate.toString()}".split(' ')[0]),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xFFC41A38), width: 2.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         )),
//                   ),
//                 ),

//                 // RaisedButton(
//                 //   elevation: 5.0,
//                 //   onPressed: () {
//                 //     showDialog(
//                 //       context: context,
//                 //       builder: (BuildContext context) {
//                 //         return AlertDialog(
//                 //           title: Text('Select your favorite color'),
//                 //           content: SingleChildScrollView(
//                 //             child: BlockPicker(
//                 //               pickerColor: currentColor,
//                 //               onColorChanged: changeColor,
//                 //             ),
//                 //           ),
//                 //         );
//                 //       },
//                 //     );
//                 //   },
//                 //   color: currentColor,
//                 //   child: const Text('Favourite Color'),
//                 //   textColor: useWhiteForeground(currentColor)
//                 //       ? const Color(0xffffffff)
//                 //       : const Color(0xff000000),
//                 // ),

//                 // Container(
//                 //   padding: EdgeInsets.only(bottom: 30.0),
//                 //   child: Row(
//                 //     children: <Widget>[
//                 //       Expanded(
//                 //         child: RaisedButton(
//                 //           elevation: 4.0,

//                 //           color: Colors.black87,
//                 //           onPressed: () {
//                 //             setState(() {
//                 //               if (_formkey.currentState.validate()) {
//                 //                 _save();
//                 //                 Navigator.push(context, MaterialPageRoute(
//                 //                   builder: (context) {
//                 //                     return Output();
//                 //                   },
//                 //                 ));
//                 //               }
//                 //             });
//                 //           },
//                 //           textColor: Theme.of(context).primaryColorDark,
//                 //           child: Text(
//                 //             "Add",
//                 //             style: TextStyle(color: Colors.white),
//                 //           ),
//                 //         ),
//                 //       ),

//                 //       Expanded(
//                 //         child: RaisedButton(
//                 //           elevation: 5.0,
//                 //           color: Color(0xFFC41A38),
//                 //           onPressed: () {
//                 //             setState(() {
//                 //               name_controller.text = '';
//                 //               add_controller.text = '';
//                 //               _selectedState = null;
//                 //             });
//                 //           },
//                 //           textColor: Theme.of(context).accentColor,
//                 //           child: Text(
//                 //             "Reset",
//                 //             style: TextStyle(color: Colors.white),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'dart:io';
import 'package:cab_driver/screens/loading.dart';
import 'package:cab_driver/widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:flutter_icons/flutter_icons.dart';

class Latest extends StatefulWidget {
  static const String id = 'latest';

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
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

  String doctorImageUrl =
      'https://fsb.zobj.net/crop.php?r=C8mIJt90CKQ7Fhn2so_QuhEhtyEV8U3TvLpk9yikc2bDTm-mLYC7Il5z0JqZw6g3q8zaFRp8wzblKV52v2-dMNym0eqSIcOXLOIoZ2pvZuhSI6QN6zYUc3LFze8o-5bNiILJaaqcs4uz23Qw';
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

  void updateProfile(context) {
    // _uploadImage();
    // _uploadIdent();
    // _uploadCert();
    String id = currentFirebaseUser.uid;
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm a');

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();

    DatabaseReference doctorRef =
        FirebaseDatabase.instance.reference().child('doctors/$id/doctor_info');

    Map<String, dynamic> map = {
      'imageUrl': doctorImageUrl,
      'dob': dobDate,
      'identUrl': doctorIdentUrl,
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

    doctorRef.update(map);

    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }

  // files required in the form
  File _imageFile;
  String imageName;
  File _identFile;
  String identName;
  File _certFile;
  String certName;

  ImagePicker imagePicker = ImagePicker();

  // Choose profile image function
  Future<void> _choosedImage() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _imageFile = File(pickedFile.path);
      imageName =
          "petambulance profile picture.${_imageFile.path.split('.').last}";
    });
  }

  // Choose identification file function
  Future<void> _choosedIdent() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _identFile = File(pickedFile.path);
      identName =
          "petambulance identity file.${_imageFile.path.split('.').last}";
    });
  }

  // Choose certificate image function
  Future<void> _choosedCert() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _certFile = File(pickedFile.path);
      certName =
          "petambulance certificate file.${_imageFile.path.split('.').last}";
    });
  }

  // Upload profile pic
  void _uploadImage() async {
    // Create a unique filename for image
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Images').child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // Save to real time database
        //updateProfile(imageUrl);
        print(imageUrl);

        if (mounted) {
          super.setState(() {
            doctorImageUrl = imageUrl;
          });
        }
        return;
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
          doctorIdentUrl = identUrl;
        });
      });
    }).catchError((error) {
      showSnackBar(
        error.toString(),
      );
    });
  }
  //  https://firebasestorage.googleapis.com/v0/b/pet-ambulance-app.appspot.com/o/Images%2F1617018308069380?alt=media&token=0811bd01-ad68-41a9-9981-3ac6eb2d1397
  // "https://firebasestorage.googleapis.com/v0/b/pet-ambulance-app.appspot.com/o/Images%2F1617017713660023?alt=media&token=72dead6a-8ea4-4c14-8451-41d825a8aa1d"
  // gs://pet-ambulance-app.appspot.com/Images/1617018308069380
  // "https://firebasestorage.googleapis.com/v0/b/pet-ambulance-app.appspot.com/o/Images%2F1617017713660023?alt=media&token=72dead6a-8ea4-4c14-8451-41d825a8aa1d"

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
          doctorCertUrl = "certUrl";
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
              SizedBox(height: 10),
              SizedBox(
                height: 10,
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
                  ],
                ),
              ),
              _imageFile == null
                  ? Image.asset(
                      'images/user_icon.png',
                      height: 100,
                      width: 100,
                    )
                  : //Image.file(_imageFile),
                  Container(
                      width: double.infinity,
                      height: 100,
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        child: CircleAvatar(
                          backgroundImage: FileImage(_imageFile),
                          radius: 60.0,
                        ),
                      ),
                    ),
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
                                top: 15, right: 15, left: 15, bottom: 15),
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

                    // IDENTIFICATION FIELD
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                        if (nin.text.length < 11) {
                          showSnackBar('Please provide a valid NIN');
                          return;
                        }

                        if (imageName == null) {
                          showSnackBar('please choose a profile picture ');
                          return;
                        }

                        if (identName == null) {
                          showSnackBar(
                              'please upload a means of identification ');
                          return;
                        }

                        if (certName == null) {
                          showSnackBar('please kindly upload your certificate');
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

                        _uploadImage();
                        _uploadIdent();
                        _uploadCert();
                        updateProfile(context);

                        //comingSoon(context);
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
