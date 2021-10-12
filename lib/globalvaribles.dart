import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'datamodels/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

User currentFirebaseUser;

Completer<GoogleMapController> _controller = Completer();

// ignore: non_constant_identifier_names
final CameraPosition GooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

String mapKey = 'AIzaSyDjkvF86Dthiwx8UxsttoW6qZAdb1wlYZQ';

StreamSubscription<Position> homeTabPositionStream;

StreamSubscription<Position> treatmentPositionStream;

final assetsAudioPlayer = AssetsAudioPlayer();

Position currentPosition;

DatabaseReference treatmentRef;

Doctor currentDoctorInfo;
