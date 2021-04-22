import '../brand_colors.dart';
import '../datamodels/doctor.dart';
import '../globalvaribles.dart';
import '../helpers/helpermethods.dart';
import '../helpers/pushnotificationservice.dart';
import '../tabs/earningstab.dart';
import '../tabs/hometab.dart';
import '../tabs/profile.dart';
import '../tabs/profiletab.dart';
import '../tabs/ratingtab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  int selectedIndex = 0;
  GoogleMapController mapController;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  // void setupPositionLocator() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currentPosition = position;

  //   LatLng pos = LatLng(position.latitude, position.longitude);
  //   CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

  //   // confirm location
  //   await HelperMethods.findCordinateAddress(position, context);
  //   // String doctorsAddress =
  //   //     await HelperMethods.findCordinateAddress(position, context);

  //   //startGeofireListener();
  // }

  void getCurrentDoctorInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    DatabaseReference doctorRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}');
    doctorRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentDoctorInfo = Doctor.fromSnapshot(snapshot);
        print('my name is ${currentDoctorInfo.fullName}');
        print('this is data list ${currentDoctorInfo}');
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
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          HomeTab(),
          ProfilePage(),
          //EarningTab(),
          //RatingsTab(),
          //ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            // ignore: deprecated_member_use
            title: Text('Profile'),
          ),
          //BottomNavigationBarItem(
          //   icon: Icon(Icons.star),
          //   // ignore: deprecated_member_use
          //   title: Text('Ratings'),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   // ignore: deprecated_member_use
          //   title: Text('Account'),
          // ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.pink[900],
        selectedItemColor: Colors.green,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}
