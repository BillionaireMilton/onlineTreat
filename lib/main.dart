import 'dart:io';
import 'dataprovider.dart';
import 'globalvaribles.dart';
import 'screens/historypage.dart';
import 'screens/loading.dart';
import 'screens/login.dart';
import 'screens/loginTec.dart';
import 'screens/mainpage.dart';
import 'screens/firstpage.dart';
import 'screens/newTreatmentPage.dart';
import 'screens/registrationTec.dart';
import 'screens/roleLog.dart';
import 'screens/roleReg.dart';
import 'screens/registration.dart';
import 'screens/doctorinfo.dart';
import 'screens/samp.dart';
import 'screens/tst.dart';
import 'screens/wait.dart';
import 'screens/profilePic.dart';
import 'tabs/profile.dart';
import 'tabs/profiletab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/tecinfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:288225958127:android:c50eef1c6173e26ca6e31a',
            apiKey: 'AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM',
            messagingSenderId: '288225958127',
            projectId: 'pet-ambulance-app',
            databaseURL:
                'https://pet-ambulance-app-default-rtdb.firebaseio.com',
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
            TecInfoPage.id: (context) => TecInfoPage(),
            LoginPage.id: (context) => LoginPage(),
            LoginTecPage.id: (context) => LoginTecPage(),
            ProfilePage.id: (context) => ProfilePage(),
            ProfilePages.id: (context) => ProfilePages(),
            FirstPage.id: (context) => FirstPage(),
            RoleLogPage.id: (context) => RoleLogPage(),
            RoleRegPage.id: (context) => RoleRegPage(),
            Latest.id: (context) => Latest(),
            // Home.id: (context) => Home(),
            MyHomePage.id: (context) => MyHomePage(),
            Loading.id: (context) => Loading(),
            NewTreatmentPage.id: (context) => NewTreatmentPage(),
            ProfilePic.id: (context) => ProfilePic(),
            HistoryPage.id: (context) => HistoryPage(),
          },
        ));
  }
}
