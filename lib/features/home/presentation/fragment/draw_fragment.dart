import 'package:smart_voyageurs/features/home/presentation/pages/home_page.dart';
import 'package:smart_voyageurs/features/home/presentation/widgets/show_routes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_voyageurs/core/injection/injection_container.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_voyageurs/core/util/flash_helper.dart';
import 'package:smart_voyageurs/core/ui/loading_dialog.dart';
import 'package:smart_voyageurs/core/mobx/mobx_point.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:smart_voyageurs/core/mobx/mobx_home.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:after_layout/after_layout.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'dart:async';


class DrawFragment extends StatefulWidget {
  @override
  _DrawFragmentState createState() => _DrawFragmentState();
}

class _DrawFragmentState extends State<DrawFragment> with AfterLayoutMixin<DrawFragment> {


  List<String> _listModeDisplay = ["Taxi", "Marchant", "Vélo", "Tram"];
  List<String> _listMode = ["Taxi", "Marchant", "Vélo", "transit"];
  double _originLatitude = 33.969825, _originLongitude = -6.842041;
  TextEditingController sourceController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position> _positionStreamSubscription;
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController _mapController;
  final MobxHome _mobx = MobxHome();
  Position _position;
  double _zoom = 14.0;

  TabController _controllerTab;
  int _selectedIndex = 0;

  @override
  void afterFirstLayout(BuildContext context) async {
    final polylines = await sl<AppUtils>().getAllPolyline();
    _mobx.polylines.addAll(polylines);
  }

  void addAllPolyline(List<LatLng> latLngs) {
    try {
      _mobx.polylines.clear();

      final String _id = Uuid().v4();
      List<LatLng> points = <LatLng>[];
      for (LatLng point in latLngs) {
        points.add(LatLng(point.latitude, point.longitude));
      }

      _mobx.polylines.add(Polyline(
          polylineId: PolylineId(_id),
          points: points,
          width: 3,
          color: Colors.pink[200]
      ));
    } catch(e) {
      print("error, $e");
    }
  }

  Future<void> _insertRoutes(BuildContext context, AppDatabase db, info) async {
    try {
      LoadingDialog.show(context);
      final String _id = Uuid().v4();
      List<DrawRoute> drawRoute = [];
      for (LatLng point in _mobx.latlngs) {
        drawRoute.add(DrawRoute(
          id_route: _id,
          latitude: point.latitude,
          longitude: point.longitude,
        ));
      }

      await db.drawRoutesDao.insertAllDrawRoutes(drawRoute);
      await db.infoRoutesDao.insertInfoRoutes(InfoRoute(
        id: _id, info: info, type: _mobx.type,),
      );

      _mobx.markers.clear();
      _mobx.latlngs.clear();
      _mobx.polylines.clear();

    } catch(e) {
      LoadingDialog.hide(context);
      // Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  sdfsd() {

  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => HomePage(null)
        ), (route) => false);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Draw a route'),
          ),
          body: Container(
            child: Observer(
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
                      _mobx.addMarker(location);
                      _mobx.addLatLng(location);

                      if (_mobx.latlngs.length > 1) {
                        addAllPolyline(_mobx.latlngs);

                        final polylines = await sl<AppUtils>().getAllPolyline();
                        _mobx.polylines.addAll(polylines);
                      }

                    },
                    markers: _mobx.markers.toSet(),
                    polylines: _mobx.polylines.toSet(),
                    initialCameraPosition: CameraPosition(
                      target: _position != null ? LatLng(
                        _mobx.latitude, _mobx.longitude,
                      ) : LatLng(_originLatitude, _originLongitude),
                      zoom: _zoom,
                    ),
                    mapType: MapType.normal,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn1",
                child: Icon(Icons.clear),
                onPressed: () async {
                  _mobx.latlngs.clear();
                  _mobx.markers.clear();
                  _mobx.polylines.clear();
                  final polylines = await sl<AppUtils>().getAllPolyline();
                  _mobx.polylines.addAll(polylines);
                },
              ),
              FloatingActionButton(
                heroTag: "btn2",
                child: Icon(Icons.save),
                onPressed: () async {
                  TextEditingController _controller = TextEditingController();
                  return await showDialog(context: context, builder: (context) => AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Container(
                      height: 60, width: width - 100,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text('Mode voyage',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.pink.shade700,
                    ),
                    content: Container(
                      width: width - 100,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                  hintText: 'Information de voyage'
                              )
                          ),
                          SizedBox(height: 10),
                          Observer(
                            builder: (_) => DropdownSearch<String>(
                              //mode: Mode.MENU,
                              // showSelectedItem: true,
                              items: _listModeDisplay,
                              hint: "sélectionnez le mode",

                              onChanged: _mobx.setType,
                              selectedItem: _mobx.type.isNotEmpty ? _mobx.type : 'sélectionnez le mode',
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () async {
                          if (_mobx.type.isEmpty) {
                            FlashHelper.errorBar(context, message: 'Sélectionnez le mode obligatoire');
                          } else if (_mobx.latlngs.isEmpty) {
                            FlashHelper.errorBar(context, message: "Point d'itinéraire obligatoire");
                          } else {
                            await _insertRoutes(context, db, _controller.text.trim()).whenComplete(() async {
                              LoadingDialog.hide(context);
                              final polylines = await sl<AppUtils>().getAllPolyline();
                              _mobx.polylines.addAll(polylines);
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                      FlatButton(
                        child: Text('Annuler'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ));
                },
              ),
              FloatingActionButton(
                heroTag: "btn3",
                child: Icon(Icons.delete),
                onPressed: () async {
                  LoadingDialog.show(context);
                  await db.delete(db.drawRoutes).go();
                  await db.delete(db.infoRoutes).go();
                  LoadingDialog.hide(context);
                  _mobx.polylines.clear();
                  setState(() {});
                },
              ),
            ],
          )
      ),
    );
  }
}
