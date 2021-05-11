import '../brand_colors.dart';
import '../datamodels/treatmentdetails.dart';
import '../globalvaribles.dart';
import '../helpers/helpermethods.dart';
import '../screens/newTreatmentPage.dart';
import '../widgets/BrandDivier.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import '../widgets/TaxiOutlineButton.dart';
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
//               'images/ambl.png',
//               width: 100,
//             ),
//             SizedBox(
//               height: 16.0,
//             ),
//             Text(
//               'NEW TREATMENT REQUEST',
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
//   final TreatmentDetails treatmentDetails;
//
//   NotificationDialog({this.treatmentDetails});
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
//               'images/ambl.png',
//               width: 100,
//             ),
//             SizedBox(
//               height: 16.0,
//             ),
//             Text(
//               'NEW TREATMENT REQUEST',
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
//                             treatmentDetails.pickupAddress,
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
//                             treatmentDetails.destinationAddress,
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
//     DatabaseReference newTreatmentRef = FirebaseDatabase.instance
//         .reference()
//         .child('doctors/${currentFirebaseUser.uid}/newtreatment');
//     newTreatmentRef.once().then((DataSnapshot snapshot) {
//       Navigator.pop(context);
//
//       String thisTreatmentID = "";
//       if (snapshot.value != null) {
//         thisTreatmentID = snapshot.value.toString();
//       } else {
//         print('treatment not found');
//       }
//
//       if (thisTreatmentID == treatmentDetails.treatmentID) {
//         newTreatmentRef.set('accepted');
//       } else if (thisTreatmentID == 'cancelled') {
//         print('treatment has been cancelled');
//       } else if (thisTreatmentID == 'timeout') {
//         print('treatment has timed out');
//       } else {
//         print('treatment not found');
//       }
//     });
//   }
// }

class NotificationDialog extends StatelessWidget {
  final TreatmentDetails treatmentDetails;

  NotificationDialog({this.treatmentDetails});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: Dialog(
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
                'images/ambl.png',
                width: 100,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'NEW TREATMENT REQUEST',
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
                          treatmentDetails.pickupAddress,
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
                          'petAmbulance',
                          // treatmentDetails.destinationAddress,
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

    DatabaseReference newTreatmentRef = FirebaseDatabase.instance
        .reference()
        .child('doctors/${currentFirebaseUser.uid}/newtreatment');
    newTreatmentRef.once().then((DataSnapshot snapshot) {
      Navigator.pop(context);
      Navigator.pop(context);

      String thisTreatmentID = "";
      if (snapshot.value != null) {
        thisTreatmentID = snapshot.value.toString();
      } else {
        Toast.show("Treatment not found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print('treatment not found');
      }

      if (thisTreatmentID == treatmentDetails.treatmentID) {
        newTreatmentRef.set('accepted');

        HelperMethods.disableHomTabLocationUpdates();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewTreatmentPage(
              treatmentDetails: treatmentDetails,
            ),
          ),
        );
      } else if (thisTreatmentID == 'cancelled') {
        Toast.show("Treatment has been cancelled", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else if (thisTreatmentID == 'timeout') {
        Toast.show("Treatment has timed out", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Treatment not found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}
