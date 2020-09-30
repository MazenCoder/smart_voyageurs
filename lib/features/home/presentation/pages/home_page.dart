import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:smart_voyageurs/core/ui/loading_dialog.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_voyageurs/core/mobx/mobx_home.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:smart_voyageurs/core/util/flash_helper.dart';



class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _startController = TextEditingController();
  final _destinationController = TextEditingController();

  double _originLatitude = 33.969825, _originLongitude = -6.842041;
  List<String> _listMode = ["driving", "walking", "bicycling"];
  static String googleAPIKey = 'AIzaSyDKcv0l6H4xJi8QGXBJgOeIv3qtCnksqDo';
  TextEditingController sourceController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position> _positionStreamSubscription;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final _formKey = GlobalKey<FormState>();
  List<LatLng> polylineCoordinates = [];
  GoogleMapController _mapController;
  final MobxHome _mobx = MobxHome();
  //final Mode _mode = Mode.overlay;
  final _positions = <Position>[];
  Position _position;
  double _zoom = 14.0;

  @override
  void initState() {
    super.initState();
    _setPermissions();
  }


  void _setPermissions() async {
    _position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _mobx.setLocation(_position);

    LocationPermission locationPermission = await checkPermission();
    print("locationPermission: $locationPermission");

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Smart Voyageurs'),
        ),
        key: _scaffoldKey,
        body: FutureBuilder<LocationPermission>(
          future: checkPermission(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == LocationPermission.denied) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Request location permission, '
                        'Access to the device\'s location has been denied, please '
                            'request permissions before continuing'),
                    RaisedButton(
                      child: const Text('Request permission'),
                      onPressed: () => requestPermission()
                          .then((status) => setState(_positions.clear)),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.data == LocationPermission.deniedForever) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Access to location permanently denied, '
                        'Allow access to the location services for this App using the '
                        'device settings.',
                  ),
                ),
              );
            }

            return Observer(
              builder: (_) => Stack(
                children: <Widget>[
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      if(!_controller.isCompleted) {
                        _controller.complete(controller);
                        _mapController = controller;
                      }

                    },
                    onCameraMove:(CameraPosition cameraPosition) {
                      _zoom = cameraPosition.zoom;
                    },
                    onTap: (LatLng location) async {
                      if (_mobx.markers.length == 1) {
                        _mobx.addMarker(location);
                        _mobx.addLatLng(location);
                        //_getPolyline(_mobx.latlngs);
                        LoadingDialog.show(context);
                        await sl<AppUtils>().getRoute(_mobx.latlngs, _listMode.first).then((value) {
                          if (value.isNotEmpty) {
                            _mobx.setPolyLine(true);
                            _addPolyLine(value);
                          }
                        }).whenComplete(() => LoadingDialog.hide(context));
                      } else if (_mobx.markers.length < 1) {
                        _mobx.addMarker(location);
                        _mobx.addLatLng(location);
                      } else {
                        _mobx.markers.clear();
                        _mobx.latlngs.clear();
                        _mobx.polylines.clear();
                        _mobx.setPolyLine(false);
                        for (int i = 0; i < _mobx.isSelected.length; i++) {
                          _mobx.isSelected[i] = false;
                        }
                        _mobx.isSelected[0] = true;
                        // _getPolyline(_mobx.markers);
                      }
                    },
                    markers: _mobx.markers.toSet(),
                    // polylines: Set<Polyline>.of(polylines.values),
                    polylines: _mobx.polylines.toSet(),
                    initialCameraPosition: CameraPosition(
                      target: _position != null ? LatLng(
                        _mobx.latitude, _mobx.longitude,
                      ) : LatLng(_originLatitude, _originLongitude),
                      zoom: _zoom,
                    ),
                    mapType: MapType.normal,
                  ),

                  if (_mobx.isPolyLine) ...[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: ToggleButtons(
                          children: <Widget>[
                            Icon(Icons.drive_eta),
                            Icon(MdiIcons.walk),
                            Icon(Icons.directions_bike),
                            // Icon(MdiIcons.train),
                          ],
                          isSelected: _mobx.isSelected,
                          onPressed: (int index) async {
                            _mobx.polylines.clear();
                            LoadingDialog.show(context);
                            print("mode: ${_listMode[index]}");
                            await sl<AppUtils>().getRoute(_mobx.latlngs, _listMode[index]).then((value) {
                              if (value.isNotEmpty) {
                              _addPolyLine(value);
                              }
                            }).whenComplete(() => LoadingDialog.hide(context));
                            for (int i = 0; i < _mobx.isSelected.length; i++) {
                              _mobx.isSelected[i] = false;
                            }

                            _mobx.isSelected[index] = !_mobx.isSelected[index];
                          },
                          selectedColor: Colors.pink,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],

                  if (_mobx.isSearch) ...[
                    Align(
                      alignment: Alignment.topCenter,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        shrinkWrap: true,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              width: width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Container(
                                      width: width * 0.8,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: _startController,
                                        validator: (val) {
                                          if(val.isEmpty)
                                            return 'required_field'.tr();
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(Icons.looks_one),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.my_location),
                                            onPressed: () {},
                                          ),
                                          labelText: "Start",
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(15),
                                          hintText: 'Choose starting point',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: width * 0.8,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: _destinationController,
                                        validator: (val) {
                                          if(val.isEmpty)
                                            return 'required_field'.tr();
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(Icons.looks_two),
                                          labelText: 'Destination',
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(15),
                                          hintText: 'Choose destination',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    RaisedButton(
                                      onPressed: () {
                                        if(_formKey.currentState.validate()) {

                                        }
                                      },
                                      color: Colors.pink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Show Route'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],


                  Column(
                    children: <Widget>[
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FloatingActionButton(
                                elevation: 2,
                                child: Icon(_mobx.isSearch ? Icons.clear : Icons.search),
                                heroTag: null,
                                onPressed: () {
                                  _startController.clear();
                                  _destinationController.clear();
                                  _mobx.setSearch(_mobx.isSearch ? false : true);
                                }
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(MdiIcons.directions),
          onPressed: () async {
            print(polylineCoordinates.length);

          },
        ),
      ),
    );
  }


  /*
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Placemark> startPlacemark =
      await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
      await _geolocator.placemarkFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        // Use the retrieved coordinates of the current position,
        // instead of the address if the start position is user's
        // current position, as it results in better accuracy.
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
            latitude: _currentPosition.latitude,
            longitude: _currentPosition.longitude)
            : startPlacemark[0].position;
        Position destinationCoordinates = destinationPlacemark[0].position;

        // Start Location Marker
        Marker startMarker = Marker(
          markerId: MarkerId('$startCoordinates'),
          position: LatLng(
            startCoordinates.latitude,
            startCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Start',
            snippet: _startAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
            destinationCoordinates.latitude,
            destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Adding the markers to the list
        markers.add(startMarker);
        markers.add(destinationMarker);

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        // Calculating to check that
        // southwest coordinate <= northeast coordinate
        if (startCoordinates.latitude <= destinationCoordinates.latitude) {
          _southwestCoordinates = startCoordinates;
          _northeastCoordinates = destinationCoordinates;
        } else {
          _southwestCoordinates = destinationCoordinates;
          _northeastCoordinates = startCoordinates;
        }

        // Accommodate the two locations within the
        // camera view of the map
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );

        // Calculating the distance between the start and the end positions
        // with a straight path, without considering any route
        // double distanceInMeters = await Geolocator().bearingBetween(
        //   startCoordinates.latitude,
        //   startCoordinates.longitude,
        //   destinationCoordinates.latitude,
        //   destinationCoordinates.longitude,
        // );

        await _createPolylines(startCoordinates, destinationCoordinates);

        double totalDistance = 0.0;

        // Calculating the total distance by adding the distance
        // between small segments
        for (int i = 0; i < polylineCoordinates.length - 1; i++) {
          totalDistance += _coordinateDistance(
            polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i + 1].latitude,
            polylineCoordinates[i + 1].longitude,
          );
        }

        setState(() {
          _placeDistance = totalDistance.toStringAsFixed(2);
          print('DISTANCE: $_placeDistance km');
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

   */

  _getPolyline(List<LatLng> latlngs) async {
    print(latlngs.map((e) => e));
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(latlngs.first.latitude, latlngs.first.latitude),
        PointLatLng(latlngs.last.latitude, latlngs.last.latitude),
        travelMode: TravelMode.walking,
        wayPoints: [PolylineWayPoint(location: "Test")]
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    //_addPolyLine();
  }

  _addPolyLine(List<LatLng> latLngs) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: latLngs, width: 2);
    _mobx.addPolyline(polyline);
    polylines[id] = polyline;
    setState(() {});
  }
}
