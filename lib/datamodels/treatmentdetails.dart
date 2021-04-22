import 'package:google_maps_flutter/google_maps_flutter.dart';

class TreatmentDetails {
  //String destinationAddress;
  String pickupAddress;
  LatLng pickup;
  //LatLng destination;
  String treatmentID;
  String paymentMethod;
  String ownerName;
  String ownerPhone;

  TreatmentDetails(
      {this.pickupAddress,
      this.treatmentID,
      //this.destinationAddress,
      //this.destination,
      this.pickup,
      this.paymentMethod,
      this.ownerName,
      this.ownerPhone});
}
