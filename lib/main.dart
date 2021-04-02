import 'dart:io';
import 'package:cab_driver/dataprovider.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/screens/historypage.dart';
import 'package:cab_driver/screens/loading.dart';
import 'package:cab_driver/screens/login.dart';
import 'package:cab_driver/screens/loginTec.dart';
import 'package:cab_driver/screens/mainpage.dart';
import 'package:cab_driver/screens/firstpage.dart';
import 'package:cab_driver/screens/newTripPage.dart';
import 'package:cab_driver/screens/registrationTec.dart';
import 'package:cab_driver/screens/roleLog.dart';
import 'package:cab_driver/screens/roleReg.dart';
import 'package:cab_driver/screens/registration.dart';
import 'package:cab_driver/screens/doctorinfo.dart';
import 'package:cab_driver/screens/samp.dart';
import 'package:cab_driver/screens/tst.dart';
import 'package:cab_driver/screens/wait.dart';
import 'package:cab_driver/screens/profilePic.dart';
import 'package:cab_driver/tabs/profile.dart';
import 'package:cab_driver/tabs/profiletab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:288225958127:android:c50eef1c6173e26ca6e31a',
            apiKey: 'AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM',
            messagingSenderId: '297855924061',
            projectId: 'flutter-firebase-plugins',
            databaseURL:
                'https://pet-ambulance-app-default-rtdb.firebaseio.com/',
          ),
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Brand-Regular',
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute:
              (currentFirebaseUser == null) ? FirstPage.id : MyHomePage.id,
          routes: {
            MainPage.id: (context) => MainPage(),
            RegistrationPage.id: (context) => RegistrationPage(),
            RegistrationTecPage.id: (context) => RegistrationTecPage(),
            DoctorInfoPage.id: (context) => DoctorInfoPage(),
            LoginPage.id: (context) => LoginPage(),
            LoginTecPage.id: (context) => LoginTecPage(),
            ProfilePage.id: (context) => ProfilePage(),
            ProfilePages.id: (context) => ProfilePages(),
            FirstPage.id: (context) => FirstPage(),
            RoleLogPage.id: (context) => RoleLogPage(),
            RoleRegPage.id: (context) => RoleRegPage(),
            // TestPage.id: (context) => TestPage(),
            // Home.id: (context) => Home(),
            MyHomePage.id: (context) => MyHomePage(),
            Loading.id: (context) => Loading(),
            NewTripPage.id: (context) => NewTripPage(),
            ProfilePic.id: (context) => ProfilePic(),
            HistoryPage.id: (context) => HistoryPage(),
          },
        ));
  }
}
