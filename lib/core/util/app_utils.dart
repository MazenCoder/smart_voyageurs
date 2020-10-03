import 'package:mobx/src/api/observable_collections.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';


abstract class AppUtils extends ChangeNotifier {

  Future<InputLogin> getCacheInputLogin();
  String generateMd5(String input);
  Future<void> logOut();
  Future<List<LatLng>> getRoute(List<LatLng> latLngs, String mode);
  String calculateDistance(List<LatLng> latlngs);

}
