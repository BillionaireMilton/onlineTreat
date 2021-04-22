import 'dart:math';
import '../datamodels/address.dart';
import '../datamodels/history.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../datamodels/directiondetails.dart';
import '../dataprovider.dart';
import '../globalvaribles.dart';
import '../helpers/requesthelper.dart';
import '../widgets/ProgressDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// class HelperMethods {
//   static Future<DirectionDetails> getDirectionDetails(
//       LatLng startPosition, LatLng endPosition) async {
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM';
//     print('URL: ${url}');
//     var response = await RequestHelper.getRequest(url);
//
//     if (response == 'failed') {
//       return null;
//     }
//
//     DirectionDetails directionDetails = DirectionDetails();
//
//     directionDetails.durationText =
//         response['routes'][0]['legs'][0]['duration']['text'];
//     directionDetails.durationValue =
//         response['routes'][0]['legs'][0]['duration']['value'];
//
//     directionDetails.distanceText =
//         response['routes'][0]['legs'][0]['distance']['text'];
//
//     directionDetails.distanceValue =
//         response['routes'][0]['legs'][0]['distance']['value'];
//
//     directionDetails.encodedPoints =
//         response['routes'][0]['overview_polyline']['points'];
//
//     return directionDetails;
//   }
//
//   static int estimateFares(DirectionDetails details, int durationValue) {
//     //per km = 6 rupees
//     //per minute = 5 rupees
//     // base fare = 20 rupees
//
//     double baseFare = 20;
//     double distanceFare = (details.distanceValue / 1000) * 6;
//     double timeFare = (durationValue / 60) * 5;
//
//     double totalFare = baseFare + distanceFare + timeFare;
//
//     return totalFare.truncate();
//   }
//
//   static double generateRandomNumber(int max) {
//     var randomGenerator = Random();
//     int randInt = randomGenerator.nextInt(max);
//
//     return randInt.toDouble();
//   }
//
//   static void disableHomeTabLocationUpdates() {
//     homeTabPositionStream.pause();
//     Geofire.removeLocation(currentFirebaseUser.uid);
//   }
//
//   static void enableHomeTabLocationUpadate() {
//     homeTabPositionStream.resume();
//     Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
//         currentPosition.longitude);
//   }
//
//   static void showProgressDialog(context) {
//     //show please wait dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => ProgressDialog(
//         status: 'Please wait',
//       ),
//     );
//   }
//
//
//   static void getHistoryInfo(context){
//
//     DatabaseReference earninRef = FirebaseDatabase.instance.reference().child('doctors/${currentFirebaseUser.uid}/earnings');
//
//     earninRef.once().then((DataSnapshot snapshot)=>{
//     if(snapshot.value != null){
//         String earnings = snapshot.value.toString();
//     Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
//   }
//
//
//     });
//
//   }

class HelperMethods {
  static Future<String> findCordinateAddress(Position position, context) async {
    String placeAddress = '';
    String st1, st2, st3, st4;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM';

    var response = await RequestHelper.getRequest(url);
    print(response);

    if (response != 'failed') {
      //placeAddress = response['results'][0]['formatted_address'];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address pickupAddress = new Address();
      pickupAddress.longitude = position.longitude;
      pickupAddress.latitude = position.latitude;
      pickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupAddress(pickupAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyC5c20n0oaT8uJmipXgITc91H7TnlZSofM';

    var response = await RequestHelper.getRequest(url);

    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details, int durationValue) {
    //per km = 6 rupees
//     //per minute = 5 rupees
//     // base fare = 20 rupees

    double baseFare = 20;
    double distanceFare = (details.distanceValue / 1000) * 6;
    double timeFare = (durationValue / 60) * 5;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static void disableHomTabLocationUpdates() {
    homeTabPositionStream.pause();
    Geofire.removeLocation(currentFirebaseUser.uid);
  }

  // static void enableHomTabLocationUpdates(){
  //   homeTabPositionStream.resume();
  //   Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);
  // }

  static void enableHomeTabLocationUpadate() {
    homeTabPositionStream.resume();
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
  }

  static void showProgressDialog(context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Please wait',
      ),
    );
  }

  static void getHistoryInfo(context) {
    DatabaseReference earningRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/earnings');

    earningRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        String earnings = snapshot.value.toString();
        Provider.of<AppData>(context, listen: false).updateEarnings(earnings);

        List<String> treatmentHistoryKeys = [];
      }
    });

    DatabaseReference historyRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/history');
    historyRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        int treatmentCount = values.length;

        //update treatment count  to data provider
        Provider.of<AppData>(context, listen: false)
            .updateTreatmentCount(treatmentCount);

        List<String> treatmentHistoryKeys = [];

        values.forEach((key, value) {
          treatmentHistoryKeys.add(key);

          // update treatment keys to data provider
          Provider.of<AppData>(context, listen: false)
              .updateTreatmentKeys(treatmentHistoryKeys);

          getHistoryData(context);
        });
      }
    });
  }

  static void getHistoryData(context) {
    var keys =
        Provider.of<AppData>(context, listen: false).treatmentHistoryKeys;

    for (String key in keys) {
      DatabaseReference historyRef =
          FirebaseDatabase.instance.reference().child('treamentRequest/$key');

      historyRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var history = History.fromSnapshot(snapshot);
          Provider.of<AppData>(context, listen: false)
              .updateTreatmentHistory(history);
          print(history.destination);
        }
      });
    }
  }

  static String formatMyDate(String datestring) {
    DateTime thisDate = DateTime.parse(datestring);

    String formattedDate =
        '${DateFormat.MMMd().format(thisDate)},${DateFormat.y().format(thisDate)} -${DateFormat.jm().format(thisDate)}';

    return formattedDate;
  }
}
