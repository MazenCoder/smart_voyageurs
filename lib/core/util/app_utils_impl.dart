import 'package:flutter/material.dart';
// import 'package:maps_toolkit/maps_toolkit.dart' as toolkite;
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
import 'package:poly/poly.dart' as poly;
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
    print('mode: $mode');
    try {
      String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${latLngs.first.latitude},${latLngs.first.longitude}&destination=${latLngs.last.latitude},${latLngs.last.longitude}&mode=driving&key=$apiKey";
      // String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${latLngs.first.latitude},${latLngs.first.longitude}&destination=${latLngs.last.latitude},${latLngs.last.longitude}&mode=$mode&key=$apiKey";
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

  String calculateDistance(List<LatLng> latlngs) {
    try {
        double totalDistance = 0.0;

        totalDistance += _coordinateDistance(
          latlngs.first.latitude,
          latlngs.first.longitude,
          latlngs.last.latitude,
          latlngs.last.longitude,
        );

        String _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');

        return _placeDistance;

    } catch (e) {
      print(e);
    }
    return '';
  }


  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  @override
  Future<List<Polyline>> getAllPolyline() async {
    try {
      List<Polyline> _polylines = [];

      List<InfoRoute> infoRoutes = await database.infoRoutesDao.getAllInfoRoutes();

      for (InfoRoute info in infoRoutes) {
        List<DrawRoute> routes = await database.drawRoutesDao.getRoutesByIdRout(info.id);

        List<LatLng> points = <LatLng>[];
        for (DrawRoute point in routes) {
          var latLng = LatLng(point.latitude, point.longitude);
          points.add(latLng);
        }
        _polylines.add(Polyline(
            polylineId: PolylineId(info.id),
            points: points, width: 3,
            color: Colors.blue[200]
        ));
      }

      return _polylines;
    } catch(e) {
      print('error: -> $e');
    }
  }

  @override
  Future<void> checkPointOverlapping(var locations) async {
    ///! init list points
    // List<Point<num>> _listLocation = [];
    // for (var val in locations) {
    //   // if (!val.inside) {
    //   _listLocation.add(Point(val.latitude, val.longitude));
    //   // }
    // }

    List<InfoRoute> infoRoutes = await database.infoRoutesDao.getAllInfoRoutes();

    for (InfoRoute info in infoRoutes) {
      List<DrawRoute> routes = await database.drawRoutesDao.getRoutesByIdRout(info.id);

      List<LatLng> _cachePoints = <LatLng>[];
      for (DrawRoute point in routes) {
        var latLng = LatLng(point.latitude, point.longitude);
        _cachePoints.add(latLng);
      }

      ///! check point
      List<Point<num>> _listCachePoints = [];

      for (var val in _cachePoints) {
        // if (!val.inside) {
        _listCachePoints.add(Point(val.latitude, val.longitude));
        // }
      }


      List<bool> _listChecked = [];
      for (var val in locations) {
        // if (!val.inside) {
        Point in1 = Point(val.latitude, val.longitude);
        poly.Polygon testPolygon = poly.Polygon(_listCachePoints);
        print('----------------------------');
        print(testPolygon.isPointInside(in1));
        if (testPolygon.isPointInside(in1)) {
          _listChecked.add(testPolygon.isPointInside(in1));
        }
        print(_listChecked.length);
      }

      //poly.Polygon _polygon = poly.Polygon(_listCachePoints);
      // poly.Polygon _polygon = poly.Polygon(_listLocation);

      // Point in1 = Point(location.latitude, location.longitude);
      // List<Point<num>> notInsidePoints = []..addAll(_listCachePoints);//..addAll([Point(75, 90)]);
      // List<bool> listOfPoint = _polygon.getList_IsListOfPointInside(notInsidePoints);


    }



    // List<Point<num>> l = [];
    //
    // for (var val in list) {
    //   if (!val.inside) {
    //     l.add(Point(val.latitude, val.longitude));
    //   }
    // }
    // /// List of Points can be passed as parameter to constructor Polygon()
    // poly.Polygon testPolygon = poly.Polygon(l);
    // Point in1 = Point(location.latitude, location.longitude);
    //
    // List<Point<num>> notInsidePoints = []..addAll(l)..addAll([Point(75, 90)]);
    //
    // List<bool> listOfPoint = testPolygon.getList_IsListOfPointInside(notInsidePoints);
    // print("listOfPoint: $listOfPoint");
    //
    // return testPolygon.isPointInside(in1);

  }


  @override
  Future<bool> pointInPolygon(var locations, String mode) async {
    print('mode -> $mode');

    List<InfoRoute> infoRoutes = await database.infoRoutesDao.getInfoRoutesByType(mode);

    for (InfoRoute info in infoRoutes) {
      List<DrawRoute> routes = await database.drawRoutesDao.getRoutesByIdRout(info.id);

      List<LatLng> points = <LatLng>[];
      for (DrawRoute point in routes) {
        var latLng = LatLng(point.latitude, point.longitude);
        points.add(latLng);
      }

      // for (var loc in locations) {
      //   int val = toolkite.PolygonUtil.locationIndexOnPath(
      //     toolkite.LatLng(loc.latitude, loc.longitude),
      //       points2, false
      //   );
      //   print('------- $val ----------');
      // }

      /*
      for (var loc in locations) {
        return await GoogleMapPolyUtil.isLocationOnPath(
            point: LatLng(loc.latitude, loc.longitude),
            polygon: points
        );
      }

      for (var loc in locations) {
        return await GoogleMapPolyUtil.isLocationOnEdge(
            point: LatLng(loc.latitude, loc.longitude),
            polygon: points
        );
      }
       */

      Polygon testPolygon = Polygon(
        polygonId: PolygonId(info.id),
        points: points,
      );

      List<bool> _listChecked = [];
      for (var val in locations) {
        bool isInside = _pointInPolygon(val, testPolygon) ?? false;
        if (isInside) {
          _listChecked.add(isInside);
        }
      }

      print('isInside: $_listChecked');
      if (_listChecked.isNotEmpty)
        return true;
      return false;
    }

  }

  bool _pointInPolygon(LatLng position, Polygon polygon) {

    // Check if the point sits exactly on a vertex
    var vertexPosition = polygon.points.firstWhere((point) => point == position, orElse: () => null);
    if (vertexPosition != null) {
      return true;
    }

    // Check if the point is inside the polygon or on the boundary
    int intersections = 0;
    var verticesCount = polygon.points.length;

    for (int i = 1; i < verticesCount; i++) {
      LatLng vertex1 = polygon.points[i - 1];
      LatLng vertex2 = polygon.points[i];

      // Check if point is on an horizontal polygon boundary
      if (vertex1.latitude == vertex2.latitude &&
          vertex1.latitude == position.latitude &&
          position.longitude > min(vertex1.longitude, vertex2.longitude) &&
          position.longitude < max(vertex1.longitude, vertex2.longitude)) {
        return true;
      }

      if (position.latitude > min(vertex1.latitude, vertex2.latitude) &&
          position.latitude <= max(vertex1.latitude, vertex2.latitude) &&
          position.longitude <= max(vertex1.longitude, vertex2.longitude) &&
          vertex1.latitude != vertex2.latitude) {
        var xinters = (position.latitude - vertex1.latitude) *
            (vertex2.longitude - vertex1.longitude) /
            (vertex2.latitude - vertex1.latitude) +
            vertex1.longitude;
        if (xinters == position.longitude) {
          // Check if point is on the polygon boundary (other than horizontal)
          return true;
        }
        if (vertex1.longitude == vertex2.longitude ||
            position.longitude <= xinters) {
          intersections++;
        }
      }
    }

    // If the number of edges we passed through is odd, then it's in the polygon.
    return intersections % 2 != 0;
  }

}