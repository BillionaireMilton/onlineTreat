import 'package:cab_driver/brand_colors.dart';
import 'package:cab_driver/datamodels/tripdetails.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/helpers/helpermethods.dart';
import 'package:cab_driver/screens/newTripPage.dart';
import 'package:cab_driver/widgets/BrandDivier.dart';
import 'package:cab_driver/widgets/ProgressDialog.dart';
import 'package:cab_driver/widgets/TaxiButton.dart';
import 'package:cab_driver/widgets/TaxiOutlineButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// class NotificationDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//           margin: EdgeInsets.all(4),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(4)),
//           child: Column(children: <Widget>[
//             SizedBox(
//               height: 30.0,
//             ),
//             Image.asset(
//               'images/taxi.png',
//               width: 100,
//             ),
//             SizedBox(
//               height: 16.0,
//             ),
//             Text(
//               'NEW TRIP REQUEST',
//               style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Image.asset(
//                             'images/pickicon.png',
//                             height: 16,
//                             width: 16,
//                           ),
//                           SizedBox(
//                             width: 18,
//                           ),
//                           Text(
//                             'OVU Close PH',
//                             style: TextStyle(fontSize: 18),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Image.asset(
//                             'images/desticon.png',
//                             height: 16,
//                             width: 16,
//                           ),
//                           SizedBox(
//                             width: 18,
//                           ),
//                           Text(
//                             'Spar PH',
//                             style: TextStyle(fontSize: 18),
//                           )
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ])),
//     );
//   }
// }
// class NotificationDialog extends StatelessWidget {
//   final TripDetails tripDetails;
//
//   NotificationDialog({this.tripDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         margin: EdgeInsets.all(4),
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(4)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(
//               height: 30.0,
//             ),
//             Image.asset(
//               'images/taxi.png',
//               width: 100,
//             ),
//             SizedBox(
//               height: 16.0,
//             ),
//             Text(
//               'NEW TRIP REQUEST',
//               style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Image.asset(
//                         'images/pickicon.png',
//                         height: 16,
//                         width: 16,
//                       ),
//                       SizedBox(
//                         width: 18,
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Text(
//                             tripDetails.pickupAddress,
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Image.asset(
//                         'images/desticon.png',
//                         height: 16,
//                         width: 16,
//                       ),
//                       SizedBox(
//                         width: 18,
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Text(
//                             tripDetails.destinationAddress,
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             BrandDivider(),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       child: TaxiOutlineButton(
//                         title: 'DECLINE',
//                         color: BrandColors.colorPrimary,
//                         onPressed: () async {
//                           assetsAudioPlayer.stop();
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Container(
//                       child: TaxiButton(
//                         title: 'ACCEPT',
//                         color: BrandColors.colorGreen,
//                         onPressed: () async {
//                           assetsAudioPlayer.stop();
//                           checkAvailablity(context);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkAvailablity(context) {
//     //show Please wait dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => ProgressDialog(
//         status: 'Accepting request',
//       ),
//     );
//
//     DatabaseReference newRideRef = FirebaseDatabase.instance
//         .reference()
//         .child('doctors/${currentFirebaseUser.uid}/newtrip');
//     newRideRef.once().then((DataSnapshot snapshot) {
//       Navigator.pop(context);
//
//       String thisRideID = "";
//       if (snapshot.value != null) {
//         thisRideID = snapshot.value.toString();
//       } else {
//         print('ride not found');
//       }
//
//       if (thisRideID == tripDetails.rideID) {
//         newRideRef.set('accepted');
//       } else if (thisRideID == 'cancelled') {
//         print('ride has been cancelled');
//       } else if (thisRideID == 'timeout') {
//         print('ride has timed out');
//       } else {
//         print('ride not found');
//       }
//     });
//   }
// }

class NotificationDialog extends StatelessWidget {
  final TripDetails tripDetails;

  NotificationDialog({this.tripDetails});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Image.asset(
              'images/taxi.png',
              width: 100,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'NEW TRIP REQUEST',
              style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/pickicon.png',
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                              child: Text(
                        tripDetails.pickupAddress,
                        style: TextStyle(fontSize: 18),
                      )))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/desticon.png',
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                              child: Text(
                        tripDetails.destinationAddress,
                        style: TextStyle(fontSize: 18),
                      )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BrandDivider(),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        title: 'DECLINE',
                        color: BrandColors.colorPrimary,
                        onPressed: () async {
                          assetsAudioPlayer.stop();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: TaxiButton(
                        title: 'ACCEPT',
                        color: BrandColors.colorGreen,
                        onPressed: () async {
                          assetsAudioPlayer.stop();
                          checkAvailablity(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void checkAvailablity(context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Accepting request',
      ),
    );

    DatabaseReference newRideRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/newtrip');
    newRideRef.once().then((DataSnapshot snapshot) {
      Navigator.pop(context);
      Navigator.pop(context);

      String thisRideID = "";
      if (snapshot.value != null) {
        thisRideID = snapshot.value.toString();
      } else {
        Toast.show("Ride not found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print('ride not found');
      }

      if (thisRideID == tripDetails.rideID) {
        newRideRef.set('accepted');

        HelperMethods.disableHomTabLocationUpdates();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewTripPage(
              tripDetails: tripDetails,
            ),
          ),
        );
      } else if (thisRideID == 'cancelled') {
        Toast.show("Ride has been cancelled", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else if (thisRideID == 'timeout') {
        Toast.show("Ride has timed out", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Ride not found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}