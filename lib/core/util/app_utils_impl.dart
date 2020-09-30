import 'package:smart_voyageurs/features/login/domain/usecases/input_login.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/network/network_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_voyageurs/core/error/exceptions.dart';
import 'package:smart_voyageurs/core/util/keys.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'app_utils.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:math';
import 'dart:io';


class AppUtilsImpl extends AppUtils {

  final apiKey = "AIzaSyDKcv0l6H4xJi8QGXBJgOeIv3qtCnksqDo";
  final NetworkInfo networkInfo;
  final SharedPreferences preferences;
  final http.Client client;
  final AppDatabase database;
  var logger = Logger();


  AppUtilsImpl({this.preferences, this.client, this.networkInfo, this.database}) {
    Future.delayed(Duration(seconds: 3)).then((_) => sl.signalReady(this));
  }

  @override
  Future<InputLogin> getCacheInputLogin() async {
    try {
      final login_json = preferences.getString(Keys.CACHED_LOGIN_INPUT);
      if (login_json != null) {
        print('login_json: $login_json');
        return InputLogin.fromJson(json.decode(login_json));
      } else {
        throw CacheException();
      }
    } catch(_) {
      if(preferences != null)
        preferences.remove(Keys.CACHED_LOGIN_INPUT);
      throw CacheException();
    }
  }

  @override
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Future<void> logOut() async {
    await preferences.clear();
    return await database.deleteAllData();
  }

  @override
  Future<String> getPlacemark(var  point) async {
    try {
      // final _geolocator = geo.Geolocator();
      // geo.GeolocatorPlatform();
      // List placemark = await _geolocator.placemarkFromCoordinates(point.latitude, point.longitude);
      // return placemark[0].name;
    } catch(e) {
      return 'point';
    }
  }

  addPointAndMarker(var location) async {
    Set<Marker> _markers = {};
    //String id = sl<AppUtils>().CreateCryptoRandomString();
    // String text = await sl<AppUtils>().getPlacemark(location);
    // final point = PointModel(
    //   id: id,
    //   info: '$text',
    //   latitude: location.latitude,
    //   longitude: location.longitude,
    // );
    // _pointModel.add(point);
    // final marker = Marker(
    //   markerId: MarkerId(point.id),
    //   infoWindow: InfoWindow(title: point.info),
    //   onTap: () async {
    //     //await _optionDialog(context, point.id, point.id, point.info);
    //     //await _deleteDialog(context, pointModel.id, pointModel.id);
    //   },
    //   position: LatLng(location.latitude, location.longitude),
    // );
    // notifyListeners();
    // return _markers.add(marker);

  }

  @override
  Future<List<LatLng>> getRoute(List<LatLng> latLngs, String mode) async {
    List<LatLng> _latLng = [];
    try {
      String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${latLngs.first.latitude},${latLngs.first.longitude}&destination=${latLngs.last.latitude},${latLngs.last.longitude}&mode=$mode&key=$apiKey";
      http.Response response = await client.get(url);
      Map values = jsonDecode(response.body);
      print("response.body: ${response.body}");
      final points = values["routes"][0]["overview_polyline"]["points"];
      print("points: $points");
      print("points: ${_decodePoly(points)}");
      _latLng.addAll(_convertToLatLng(_decodePoly(points)));
      return _latLng;
    } catch(e) {
      print('error: --> $e');
      return _latLng;
    }
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = [];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    try {
      String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&mode=transit&key=$apiKey";
      //String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
      http.Response response = await http.get(url);
      Map values = jsonDecode(response.body);
      return values["routes"][0]["overview_polyline"]["points"];
    } catch(e) {
      return "";
    }
  }

  List _decodePoly(String poly) {
    var lList = new List();
    if (poly.isNotEmpty) {
      var list = poly.codeUnits;

      int index = 0;
      int len = poly.length;
      int c = 0;

      do {
        var shift = 0;
        int result = 0;

        do {
          c = list[index] - 63;
          result |= (c & 0x1F) << (shift * 5);
          index++;
          shift++;
        } while (c >= 32);

        if (result & 1 == 1) {
          result = ~result;
        }
        var result1 = (result >> 1) * 0.00001;
        lList.add(result1);
      } while (index < len);

      for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
      print(lList.toString());
      return lList;
    } else return lList;
  }

  void createRoute(String encondedPoly) {
    /*
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.pink));
    _isLoading = false;
    notifyListeners();
     */
  }
}