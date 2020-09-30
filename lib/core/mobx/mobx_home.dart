import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'mobx_home.g.dart';

class MobxHome = MobxHomeBase with _$MobxHome;

abstract class MobxHomeBase with Store {

  @observable
  ObservableList<bool> isSelected = ObservableList<bool>.of([true, false, false]);

  @observable
  ObservableList<Marker> markers = ObservableList<Marker>();

  @observable
  ObservableList<LatLng> latlngs = ObservableList<LatLng>();

  @observable
  ObservableList<Polyline> polylines = ObservableList<Polyline>();

  @observable
  double latitude = 33.969825;

  @observable
  double longitude = -6.842041;

  @observable
  bool alert = false;

  @observable
  bool isSearch = false;

  @observable
  bool isPolyLine = false;

  @action
  void setSearch(bool val) => this.isSearch = val;

  @action
  void setPolyLine(bool val) => this.isPolyLine = val;

  @action
  void setLocation(Position val) {
    if (val != null) {
      this.latitude = val.latitude;
      this.longitude = val.longitude;
    }
  }

  @action
  void addLatLng(LatLng val) {
    if (val != null) {
      this.latlngs.add(val);
    }
  }

  @action
  void addPolyline(Polyline val) {
    if (val != null) {
      polylines.add(val);
    }
  }

  @action
  void addMarker(LatLng val) {
    if (val != null) {
      final marker = Marker(
        markerId: MarkerId(val.longitude.toString()),
        //infoWindow: InfoWindow(),
        onTap: () async {

        },
        position: LatLng(val.latitude, val.longitude),
      );
      markers.add(marker);
    }
  }

  @action
  void setAlert(bool val) {
    this.alert = val;
  }

  @observable
  int currentIndex = 0;

  @action
  void setIndex(int val) => this.currentIndex = val;

  @observable
  String query = '';

  @action
  void setQuery(String search) => this.query = search;

}