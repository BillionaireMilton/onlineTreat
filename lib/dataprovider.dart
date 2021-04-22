import 'datamodels/address.dart';
import 'datamodels/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'datamodels/doctor.dart';
import 'globalvaribles.dart';
import 'helpers/helpermethods.dart';

class AppData extends ChangeNotifier {
  String earnings = '0';
  int treatmentCount = 0;
  List<String> treatmentHistoryKeys = [];
  List<History> treatmentHistory = [];
  Address pickupAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateEarnings(String newEarnings) {
    earnings = newEarnings;
    notifyListeners();
  }

  void updateTreatmentCount(int newTreatmentCount) {
    treatmentCount = newTreatmentCount;
    notifyListeners();
  }

  void updateTreatmentKeys(List<String> newKeys) {
    treatmentHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTreatmentHistory(History historyItem) {
    treatmentHistory.add(historyItem);
    notifyListeners();
  }
}
