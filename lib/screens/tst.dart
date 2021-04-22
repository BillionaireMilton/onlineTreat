// import '../screens/mainpage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_icons/flutter_icons.dart';

// class CustomPicker extends CommonPickerModel {
//   String digits(int value, int length) {
//     return '$value'.padLeft(length, "0");
//   }

//   CustomPicker({DateTime currentTime, LocaleType locale})
//       : super(locale: locale) {
//     this.currentTime = currentTime ?? DateTime.now();
//     this.setLeftIndex(this.currentTime.hour);
//     this.setMiddleIndex(this.currentTime.minute);
//     this.setRightIndex(this.currentTime.second);
//   }

//   @override
//   String leftStringAtIndex(int index) {
//     if (index >= 0 && index < 24) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }

//   @override
//   String middleStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }

//   @override
//   String rightStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }

//   @override
//   String leftDivider() {
//     return "|";
//   }

//   @override
//   String rightDivider() {
//     return "|";
//   }

//   @override
//   List<int> layoutProportions() {
//     return [1, 2, 1];
//   }

//   @override
//   DateTime finalTime() {
//     return currentTime.isUtc
//         ? DateTime.utc(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex())
//         : DateTime(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex());
//   }
// }

// class TestPage extends StatefulWidget {
//   static const String id = 'test';
//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   DateTime selectedDateTime;
//   bool pressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Datetime Picker'),
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
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: GestureDetector(
//                 onTap: () async {
//                   setState(() {
//                     pressed = true;

//                     DatePicker.showDatePicker(context, showTitleActions: true,
//                         onChanged: (date) {
//                       print('change $date in time zone ' +
//                           date.timeZoneOffset.inHours.toString());
//                     }, onConfirm: (date) {
//                       selectedDateTime = date;
//                     }, currentTime: DateTime.now());
//                   });
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       // color: Colors.pink[800],
//                       border: Border.all(color: Colors.green),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: 15, right: 15, left: 15, bottom: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           (FontAwesome.calendar),
//                           color: Colors.green,
//                           size: 20,
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           selectedDateTime == null
//                               ? "Tap to select date of birth"
//                               : '${selectedDateTime}',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 20,
//                           ),
//                         ),
//                         Container()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 50),
//             pressed ? _displayDateTime(selectedDateTime) : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _displayDateTime(selectedDateTime) {
//     return Center(
//         child: Column(
//       children: [
//         Text(
//           "Selected  $selectedDateTime",
//           style: TextStyle(fontSize: 15),
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.all(10),
//         //   child: GestureDetector(
//         //     onTap: () async {
//         //       setState(() {
//         //         pressed = true;

//         //         DatePicker.showDatePicker(context, showTitleActions: true,
//         //             onChanged: (date) {
//         //           print('change $date in time zone ' +
//         //               date.timeZoneOffset.inHours.toString());
//         //         }, onConfirm: (date) {
//         //           selectedDateTime = date;
//         //         }, currentTime: DateTime.now());
//         //       });
//         //     },
//         //     child: Container(
//         //       decoration: BoxDecoration(
//         //           // color: Colors.pink[800],
//         //           border: Border.all(color: Colors.green),
//         //           borderRadius: BorderRadius.circular(5)),
//         //       child: Padding(
//         //         padding:
//         //             EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
//         //         child: Row(
//         //           mainAxisAlignment: MainAxisAlignment.start,
//         //           crossAxisAlignment: CrossAxisAlignment.center,
//         //           children: <Widget>[
//         //             Icon(
//         //               (FontAwesome.id_card),
//         //               color: Colors.green,
//         //               size: 20,
//         //             ),
//         //             SizedBox(width: 10),
//         //             Text(
//         //               selectedDateTime == null
//         //                   ? "Tap to select date of birth"
//         //                   : '${selectedDateTime}',
//         //               style: TextStyle(
//         //                 color: Colors.green,
//         //                 fontSize: 20,
//         //               ),
//         //             ),
//         //             Container()
//         //           ],
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     ));
//   }
// }

import 'dart:async';
import '../datamodels/doctor.dart';
import '../globalvaribles.dart';
import '../screens/login.dart';
import '../screens/doctorinfo.dart';
import '../tabs/profile.dart';
import '../widgets/AvailabilityButton.dart';
import '../widgets/BrandDivier.dart';
import '../widgets/ConfirmSheet.dart';
import '../widgets/ConfirmUpdate.dart';
import '../widgets/ProgressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeTabs extends StatefulWidget {
  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DatabaseReference treatmentRequestRef;

  bool _loading = false;

  Future<void> signOut() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you out',
      ),
    );
    await FirebaseAuth.instance.signOut();
  }

  bool drawerCanOpen = true;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var geoLocator = Geolocator();

  var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  String availabilityTitle = 'GO ONLINE';
  Color availabilityColor = Colors.pink[900];
  String prof = "null";

  bool isAvailable = false;

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  Future<String> getCurrentDoctorInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    DatabaseReference doctorRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}');
    doctorRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentDoctorInfo = Doctor.fromSnapshot(snapshot);
        print('my name is ${currentDoctorInfo.fullName}');
        print('this is data list ${currentDoctorInfo}');
        return currentDoctorInfo;
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDoctorInfo();
  }

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "loading.. wait...",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentDoctorInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              key: scaffoldKey,
              drawer: Container(
                width: 250,
                color: Colors.white,
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 160,
                        child: DrawerHeader(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: <Widget>[
                              "${currentDoctorInfo.imageUrl}" != "null"
                                  ? Image.network(
                                      currentDoctorInfo.imageUrl,
                                      height: 60,
                                      width: 60,
                                    )
                                  : Image.asset(
                                      'images/user_icon.png',
                                      height: 60,
                                      width: 60,
                                    ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    currentDoctorInfo?.fullName ??
                                        "Doctor's Name",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'Brand-Bold'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    currentDoctorInfo?.email ??
                                        "Doctor's email",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      BrandDivider(),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(OMIcons.person),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ProfilePage.id, (route) => false);
                          // changeScreenReplacement(context, LoginScreen());
                        },
                      ),
                      ListTile(
                        leading: Icon(OMIcons.person),
                        title: Text(
                          'Loading',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, DoctorInfoPage.id, (route) => false);
                          // changeScreenReplacement(context, LoginScreen());
                        },
                      ),
                      ListTile(
                        leading: Icon(OMIcons.info),
                        title: Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        // dense: true,
                        // visualDensity:
                        //     VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(Icons.exit_to_app),
                        title: Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => ProgressDialog(
                              status: 'Logging you out',
                            ),
                          );
                          signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.id, (route) => false);
                          // changeScreenReplacement(context, LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: Stack(
                children: <Widget>[
                  GoogleMap(
                    padding: EdgeInsets.only(top: 100),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: GooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      mapController = controller;
                      getCurrentDoctorInfo();
                      getCurrentPosition();
                    },
                  ),
                  // Container(
                  //   height: 140,
                  //   width: double.infinity,
                  //   color: BrandColors.colorPrimary,
                  // ),

                  ///MenuButton
                  Positioned(
                    top: 80,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        if (drawerCanOpen) {
                          scaffoldKey.currentState.openDrawer();
                        } else {
                          setState(() {
                            drawerCanOpen = true;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(
                                    0.7,
                                    0.7,
                                  ))
                            ]),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            (drawerCanOpen)
                                ? Icons.menu
                                : Icons.keyboard_arrow_left,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 500,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        "${currentDoctorInfo.comp}" == "null"
                            ? AvailabilityButton(
                                title: "Update Your Profile",
                                color: Colors.pink[900],
                                onPressed: () {
                                  showModalBottomSheet(
                                    isDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ConfirmUpdate(
                                      title: "UPDATE PROFILE?",
                                      subtitle:
                                          "Kindly update your profile to be able to receive petambulance requests ",
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            DoctorInfoPage.id,
                                            (route) => false);
                                      },
                                    ),
                                  );
                                },
                              )
                            : "${currentDoctorInfo.comp}" == "1"
                                ? AvailabilityButton(
                                    title: availabilityTitle,
                                    color: availabilityColor,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ConfirmSheet(
                                          title: (!isAvailable)
                                              ? 'GO ONLINE'
                                              : 'GO OFFLINE',
                                          subtitle: (!isAvailable)
                                              ? 'You are about to become available to receive petambulance requests'
                                              : 'you will stop receiving new petambulance requests',
                                          onPressed: () {
                                            if (!isAvailable) {
                                              GoOnline();
                                              getLocationUpdates();
                                              Navigator.pop(context);

                                              setState(() {
                                                availabilityColor =
                                                    Colors.green;
                                                availabilityTitle =
                                                    'GO OFFLINE';
                                                isAvailable = true;
                                              });
                                            } else {
                                              GoOffline();
                                              Navigator.pop(context);
                                              setState(() {
                                                availabilityColor =
                                                    Colors.pink[900];
                                                availabilityTitle = 'GO ONLINE';
                                                isAvailable = false;
                                              });
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.pink[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              right: 15,
                                              left: 15,
                                              bottom: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Your profile is being verified \n kindly wait while we verify your documents",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return bodyProgress;
          }
        });
  }

  void GoOnline() {
    Geofire.initialize('doctorsAvailable');
    print(currentFirebaseUser);
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);

    treatmentRequestRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/newtreatment');
    treatmentRequestRef.set('waiting');

    treatmentRequestRef.onValue.listen((event) {});
  }

  void GoOffline() {
    Geofire.removeLocation(currentFirebaseUser.uid);
    treatmentRequestRef.onDisconnect();
    treatmentRequestRef.remove();
    treatmentRequestRef = null;
  }

  void getLocationUpdates() {
    homeTabPositionStream =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isAvailable) {
        Geofire.setLocation(
            currentFirebaseUser.uid, position.latitude, position.longitude);
      }

      LatLng pos = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }
}
