import '../brand_colors.dart';
import '../datamodels/history.dart';
import '../dataprovider.dart';
import '../screens/historypage.dart';
import '../screens/mainpage.dart';
import '../widgets/BrandDivier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../brand_colors.dart';
import '../datamodels/directiondetails.dart';
import '../globalvaribles.dart';
import '../widgets/BrandDivier.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'dart:io';
import '../helpers/helpermethods.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profilepage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  // double searchSheetHeight = (Platform.isIOS) ? 300 : 230;
  // double treatmentDetailsSheetHeight = 0; // (Platform.isAndroid) ? 235 : 260
  // double requestingSheetHeight = 0; // (Platform.isAndroid) ? 195 : 220
  // double treatmentSheetHeight = 0; // (Platform.isAndroid) ? 275 : 300

  // Completer<GoogleMapController> _controller = Completer();
  // GoogleMapController mapController;
  // double mapBottomPadding = 0;

  // List<LatLng> polylineCoordinates = [];
  // Set<Polyline> _polylines = {};
  // Set<Marker> _Markers = {};
  // Set<Circle> _Circles = {};

  final FirebaseAuth auth = FirebaseAuth.instance;
  // BitmapDescriptor nearbyIcon;

  var geoLocator = Geolocator();
  Position currentPosition;
  // DirectionDetails treatmentDirectionDetails;

  String appState = 'NORMAL';

  // bool drawerCanOpen = true;

  DatabaseReference treatmentRef;

  // StreamSubscription<Event> treatmentSubscription;

  // bool nearbyDoctorsKeysLoaded = false;

  // bool isRequestingLocationDetails = false;

  // void setupPositionLocator() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currentPosition = position;

  //   LatLng pos = LatLng(position.latitude, position.longitude);
  //   CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

  //   //startGeofireListener();
  // }

  // void showDetailSheet() async {
  //   //await getDirection();

  //   setState(() {
  //     searchSheetHeight = 0;
  //     mapBottomPadding = (Platform.isAndroid) ? 240 : 230;
  //     treatmentDetailsSheetHeight = (Platform.isAndroid) ? 235 : 260;
  //     drawerCanOpen = false;
  //   });
  // }

  // void showRequestingSheet() {
  //   setState(() {
  //     treatmentDetailsSheetHeight = 0;
  //     requestingSheetHeight = (Platform.isAndroid) ? 195 : 220;
  //     mapBottomPadding = (Platform.isAndroid) ? 200 : 190;
  //     drawerCanOpen = true;
  //   });

  //   //createtreatmentRequest();
  // }

  // showTreatmentSheet() {
  //   setState(() {
  //     requestingSheetHeight = 0;
  //     treatmentSheetHeight = (Platform.isAndroid) ? 275 : 300;
  //     mapBottomPadding = (Platform.isAndroid) ? 280 : 270;
  //   });
  // }

  // void createMarker() {
  //   if (nearbyIcon == null) {
  //     ImageConfiguration imageConfiguration =
  //         createLocalImageConfiguration(context, size: Size(2, 2));
  //     BitmapDescriptor.fromAssetImage(
  //             imageConfiguration,
  //             (Platform.isIOS)
  //                 ? 'images/car_ios.png'
  //                 : 'images/car_android.png')
  //         .then((icon) {
  //       nearbyIcon = icon;
  //     });
  //   }
  // }

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    //LatLng pos = LatLng(position.latitude, position.longitude);
    //mapController.animateCamera(CameraUpdate.newLatLng(pos));

    //     // confirm location
    HelperMethods.findCordinateAddress(position, context);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit Pet Ambulance'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    //createMarker();

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // setState(() {
            //   counter = counter + 1;
            // });
          },
          child: Container(
            width: 60,
            height: 60,
            child: Icon(Icons.edit),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.pink[900]],
                )),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.pink[900]],
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          IconButton(
                            alignment: Alignment.bottomLeft,
                            icon: Icon(Icons.keyboard_arrow_left),
                            color: Colors.white,
                            onPressed: () {
                              // Navigator.pop(context, 'mainpage');
                              Navigator.pushNamedAndRemoveUntil(
                                  context, MainPage.id, (route) => false);
                            },
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 45.0,
                        backgroundImage:
                            "${currentDoctorInfo.imageUrl}" != "null"
                                ? NetworkImage(currentDoctorInfo.imageUrl)
                                : AssetImage('images/user_icon.png'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(currentDoctorInfo?.fullName ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        currentDoctorInfo?.email ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      )
                    ]),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Card(
                        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        child: Container(
                          width: 310.0,
                          height: 290.0,
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Information",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.place,
                                            color: Colors.green,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 4.0, 0.0, 0.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Your current location",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  // "${currentDoctorInfo.address}" !=
                                                  //         "null"
                                                  //     ? "${currentDoctorInfo.address}"
                                                  //     : "Your address",

                                                  // currentPosition != null
                                                  //     ? currentPosition.toString()
                                                  //     : "Your Current Location",

                                                  Provider.of<AppData>(context)
                                                              .pickupAddress !=
                                                          null
                                                      ? Provider.of<AppData>(
                                                              context)
                                                          .pickupAddress
                                                          .placeName
                                                      : "Your Current Location",
                                                  style: TextStyle(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 4.0, 0.0, 0.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Phone",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  currentDoctorInfo?.phone ??
                                                      "+90055005",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.green,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.38,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: [
                  // Card(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(16.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Ratings",
                  //           style: TextStyle(
                  //             color: Colors.pink[900],
                  //             fontSize: 22.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         stars(
                  //             rating: userProvider.userModel.rating,
                  //             votes: userProvider.userModel.votes),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Card(
                    child: Container(
                      //height: 70,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Treatments',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Column(children: [
                            //     Text(
                            //       'Birthday',
                            //       style: TextStyle(
                            //           color: Colors.grey[400], fontSize: 14.0),
                            //     ),
                            //     SizedBox(
                            //       height: 5.0,
                            //     ),
                            //     Text(
                            //       'April 7th',
                            //       style: TextStyle(
                            //         fontSize: 15.0,
                            //       ),
                            //     )
                            //   ]),
                            // ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Date of Birth',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      currentDoctorInfo?.dob ?? "dob",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      currentDoctorInfo?.gender ??
                                          "gender here",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
