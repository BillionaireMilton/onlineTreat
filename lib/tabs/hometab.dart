import 'dart:async';
import '../datamodels/doctor.dart';
import '../globalvaribles.dart';
import '../helpers/helpermethods.dart';
import '../helpers/pushnotificationservice.dart';
import '../screens/firstpage.dart';
import '../screens/historypage.dart';
import '../screens/loading.dart';
import '../screens/login.dart';
import '../screens/doctorinfo.dart';
import '../screens/newTreatmentPage.dart';
import '../screens/profilePic.dart';
import '../screens/samp.dart';
import '../screens/tst.dart';
import '../tabs/profile.dart';
import '../tabs/profiletab.dart';
import '../widgets/AvailabilityButton.dart';
import '../widgets/BrandDivier.dart';
import '../widgets/ConfirmSheet.dart';
import '../widgets/ConfirmUpdate.dart';
import '../widgets/NotificationDialog.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../brand_colors.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launched;

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

  DatabaseReference treatmentRequestRef;

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
    //final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void performLogOut() async {
    await signOut();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you out',
      ),
    );
    await signOut();
    Navigator.pushNamedAndRemoveUntil(context, FirstPage.id, (route) => false);
    // changeScreenReplacement(context, LoginScreen());
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
      }
    });
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();

    HelperMethods.getHistoryInfo(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDoctorInfo();
    getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentPosition());
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
    getCurrentPosition();
    const String about = 'https://www.petambulance.ng/about';
    const String store = 'http://www.petambulance.ng/store';
    //getCurrentPosition();
    // getLocationUpdates();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: FutureBuilder(
          future: getCurrentDoctorInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              getCurrentPosition();
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
                                CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage:
                                      "${currentDoctorInfo.imageUrl}" != "null"
                                          ? NetworkImage(
                                              currentDoctorInfo.imageUrl)
                                          : AssetImage('images/user_icon.png'),
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        currentDoctorInfo?.fullName ??
                                            "Doctor's Name",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Brand-Bold'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        currentDoctorInfo?.email ??
                                            "Doctor's email",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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
                        // ListTile(
                        //   leading: Icon(OMIcons.acUnit),
                        //   title: Text(
                        //     'profilePic',
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     Navigator.pushNamedAndRemoveUntil(
                        //         context, Latest.id, (route) => false);
                        //     // changeScreenReplacement(context, LoginScreen());
                        //   },
                        // ),
                        ListTile(
                          leading: Icon(OMIcons.history),
                          title: Text(
                            'History',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, HistoryPage.id, (route) => false);
                            // changeScreenReplacement(context, LoginScreen());
                          },
                        ),

                        ListTile(
                          leading: Icon(OMIcons.store),
                          title: Text(
                            'My Store',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _launched = _launchInWebViewWithJavaScript(store);
                            });
                          },
                        ),

                        ListTile(
                          leading: Icon(OMIcons.info),
                          title: Text(
                            'About Petambulance',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _launched = _launchInBrowser(about);
                            });
                          },
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
                          onTap: () async {
                            await performLogOut();
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
                      onMapCreated: (GoogleMapController controller) async {
                        _controller.complete(controller);
                        mapController = controller;
                        await getCurrentDoctorInfo();
                        getCurrentPosition();
                        // checkRequest();
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
                      top: 400,
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
                                              ProfilePic.id,
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
                                                // getCurrentPosition();
                                                // getLocationUpdates();
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
                                                  availabilityTitle =
                                                      'GO ONLINE';
                                                  isAvailable = false;
                                                });
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  : Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () async {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.pink[800],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
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
                                                  Expanded(
                                                    child: Text(
                                                      "Kindly wait while we verify your documents",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
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
          }),
    );
  }

  void GoOnline() {
    getCurrentPosition();
    Geofire.initialize('doctorsAvailable');
    print(currentFirebaseUser);
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);

    treatmentRequestRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/newtreatment');
    treatmentRequestRef.set('waiting');

    treatmentRequestRef.onValue.listen((event) {});
    getLocationUpdates();
  }

  void GoOffline() {
    getCurrentPosition();

    Geofire.removeLocation(currentFirebaseUser.uid);
    getLocationUpdates();
    treatmentRequestRef.onDisconnect();
    treatmentRequestRef.remove();
    treatmentRequestRef = null;
    getLocationUpdates();
  }

  void getLocationUpdates() {
    //StreamSubscription<Position> homeTabPostionStream;

    homeTabPositionStream = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 4)
        .listen((Position position) {
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
