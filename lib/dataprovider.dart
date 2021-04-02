import 'package:cab_driver/datamodels/address.dart';
import 'package:cab_driver/datamodels/history.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  String earnings = '0';
  int tripCount = 0;
  List<String> tripHistoryKeys = [];
  List<History> tripHistory = [];
  Address pickupAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateEarnings(String newEarnings) {
    earnings = newEarnings;
    notifyListeners();
  }

  void updateTripCount(int newTripCount) {
    tripCount = newTripCount;
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys) {
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTripHistory(History historyItem) {
    tripHistory.add(historyItem);
    notifyListeners();
  }
}
