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
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'dart:async';


class ShowRoutes extends StatefulWidget {
  @override
  _ShowRoutesState createState() => _ShowRoutesState();
}

class _ShowRoutesState extends State<ShowRoutes> {

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
  // final Mode _mode = Mode.overlay;
  Position _position;
  double _zoom = 14.0;

  void _addMarkers(List<Polyline> polylines) {
    _mobx.latlngs.clear();
    // _mobx.markers.clear();
    for(Polyline polyline in polylines) {
      _mobx.latlngs.addAll(polyline.points);

      // for(LatLng latLng in polyline.points) {
      //   var _latLng = LatLng(latLng.latitude, latLng.longitude);
      //   _mobx.addMarker(_latLng);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    var width = MediaQuery.of(context).size.width;
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Show route'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () async {
                LoadingDialog.show(context);
                await db.delete(db.drawRoutes).go();
                await db.delete(db.infoRoutes).go();
                LoadingDialog.hide(context);
                setState(() {});
              },
            )
          ],
        ),
        body: FutureBuilder<List<Polyline>>(
          future: sl<AppUtils>().getAllPolyline(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting: return Center(
                child: CircularProgressIndicator(),
              );
              default:
                if (snapshot.data.isNotEmpty) {
                  _mobx.polylines.clear();
                  _mobx.polylines.addAll(snapshot.data);
                  _addMarkers(snapshot.data);
                  return Observer(
                    builder: (_) => GoogleMap(
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
                      // onTap: (LatLng location) async {
                      //   _mobx.addMarker(location);
                      //   _mobx.addLatLng(location);
                      //
                      //   if (_mobx.latlngs.length > 1) {
                      //     addAllPolyline(_mobx.latlngs);
                      //   }
                      //
                      // },
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
                  );
                } return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Le point de liste est vide'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

}
