import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../datamodels/treatmentdetails.dart';
import '../globalvaribles.dart';
import '../widgets/NotificationDialog.dart';
import '../widgets/ProgressDialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PushNotificationService {
//   final FirebaseMessaging fcm = FirebaseMessaging();
//
//   Future initialize(context) async {
//     fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         fetchTreatmentInfo(getTreatmentID(message), context);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         fetchTreatmentInfo(getTreatmentID(message), context);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         fetchTreatmentInfo(getTreatmentID(message), context);
//       },
//     );
//   }
//
//   Future<String> getToken() async {
//     String token = await fcm.getToken();
//     print('token : $token');
//
//     DatabaseReference tokenRef = FirebaseDatabase.instance
//         .reference()
//         .child('doctors/${currentFirebaseUser.uid}/token');
//     tokenRef.set(token);
//
//     fcm.subscribeToTopic('alldoctors');
//     fcm.subscribeToTopic('allusers');
//   }
//
//   String getTreatmentID(Map<String, dynamic> message) {
//     String treatmentID = '';
//
//     if (Platform.isAndroid) {
//       treatmentID = message['data']['treatment_id'];
//       // print("onResume: $message");
//     } else {
//       treatmentID = message['treatment_id'];
//       print('treatment_id: $treatmentID');
//     }
//     return treatmentID;
//   }
//
//   void fetchTreatmentInfo(String treatmentID, context) {
//     //Show please wait dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => ProgressDialog(
//         status: 'Fetching details',
//       ),
//     );
//
//     DatabaseReference treatmentRef =
//         FirebaseDatabase.instance.reference().child('treatmentRequest/$treatmentID');
//     treatmentRef.once().then((DataSnapshot snapshot) {
//       Navigator.pop(context);
//
//       if (snapshot.value != null) {
//         assetsAudioPlayer.open(
//           Audio('sounds/alert.mp3'),
//         );
//
//         assetsAudioPlayer.play();
//
//         double pickupLat =
//             double.parse(snapshot.value['location']['latitude'].toString());
//         double pickupLng =
//             double.parse(snapshot.value['location']['longitude'].toString());
//         String pickupAddress = snapshot.value['pickup_Address'].toString();
//
//         double destinationLat =
//             double.parse(snapshot.value['destination']['latitude'].toString());
//         double destinationLng =
//             double.parse(snapshot.value['destination']['longitude'].toString());
//         String destinationAddress = snapshot.value['destination_address'];
//         String paymentMethod = snapshot.value['payment_method'];
//
//         TreatmentDetails treatmentDetails = TreatmentDetails();
//
//         treatmentDetails.treatmentID = treatmentID;
//         treatmentDetails.pickupAddress = pickupAddress;
//         treatmentDetails.destinationAddress = destinationAddress;
//         treatmentDetails.pickup = LatLng(pickupLat, pickupLng);
//         treatmentDetails.destination = LatLng(destinationLat, destinationLng);
//         treatmentDetails.paymentMethod = paymentMethod;
//
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) => NotificationDialog(
//             treatmentDetails: treatmentDetails,
//           ),
//         );
//       }
//     });
//   }
// }
class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize(context) async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        fetchTreatmentInfo(getTreatmentID(message), context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        fetchTreatmentInfo(getTreatmentID(message), context);
      },
      onResume: (Map<String, dynamic> message) async {
        fetchTreatmentInfo(getTreatmentID(message), context);
      },
    );
  }

  Future<String> getToken() async {
    String token = await fcm.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/token');
    tokenRef.set(token);

    fcm.subscribeToTopic('alldoctors');
    fcm.subscribeToTopic('allusers');
  }

  String getTreatmentID(Map<String, dynamic> message) {
    String treatmentID = '';

    if (Platform.isAndroid) {
      treatmentID = message['data']['treatment_id'];
    } else {
      treatmentID = message['treatment_id'];
      print('treatment_id: $treatmentID');
    }

    return treatmentID;
  }

  void fetchTreatmentInfo(String treatmentID, context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Fetching details',
      ),
    );

    DatabaseReference treatmentRef = FirebaseDatabase.instance
        .reference()
        .child('treatmentRequest/$treatmentID');
    treatmentRef.once().then((DataSnapshot snapshot) {
      Navigator.pop(context);

      if (snapshot.value != null) {
        assetsAudioPlayer.open(
          Audio('sounds/alert.mp3'),
        );
        assetsAudioPlayer.play();

        double pickupLat =
            double.parse(snapshot.value['location']['latitude'].toString());
        double pickupLng =
            double.parse(snapshot.value['location']['longitude'].toString());
        String pickupAddress = snapshot.value['pickup_address'].toString();

        // double destinationLat =
        //     double.parse(snapshot.value['destination']['latitude'].toString());
        // double destinationLng =
        //     double.parse(snapshot.value['destination']['longitude'].toString());
        // String destinationAddress = snapshot.value['destination_address'];
        String paymentMethod = snapshot.value['payment_method'];
        String ownerName = snapshot.value['owner_name'];
        String ownerPhone = snapshot.value['owner_phone'];

        TreatmentDetails treatmentDetails = TreatmentDetails();

        treatmentDetails.treatmentID = treatmentID;
        treatmentDetails.pickupAddress = pickupAddress;
        //treatmentDetails.destinationAddress = destinationAddress;
        treatmentDetails.pickup = LatLng(pickupLat, pickupLng);
        //treatmentDetails.destination = LatLng(destinationLat, destinationLng);
        treatmentDetails.paymentMethod = paymentMethod;
        treatmentDetails.ownerName = ownerName;
        treatmentDetails.ownerPhone = ownerPhone;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(
            treatmentDetails: treatmentDetails,
          ),
        );
      }
    });
  }
}
