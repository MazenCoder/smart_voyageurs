// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_point.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxPoint on MobxPointBase, Store {
  final _$pointModelAtom = Atom(name: 'MobxPointBase.pointModel');

  @override
  ObservableList<PointModel> get pointModel {
    _$pointModelAtom.reportRead();
    return super.pointModel;
  }

  @override
  set pointModel(ObservableList<PointModel> value) {
    _$pointModelAtom.reportWrite(value, super.pointModel, () {
      super.pointModel = value;
    });
  }

  final _$markersAtom = Atom(name: 'MobxPointBase.markers');

  @override
  ObservableList<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(ObservableList<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$latLngsAtom = Atom(name: 'MobxPointBase.latLngs');

  @override
  ObservableList<LatLng> get latLngs {
    _$latLngsAtom.reportRead();
    return super.latLngs;
  }

  @override
  set latLngs(ObservableList<LatLng> value) {
    _$latLngsAtom.reportWrite(value, super.latLngs, () {
      super.latLngs = value;
    });
  }

  final _$polylineAtom = Atom(name: 'MobxPointBase.polyline');

  @override
  ObservableList<Polyline> get polyline {
    _$polylineAtom.reportRead();
    return super.polyline;
  }

  @override
  set polyline(ObservableList<Polyline> value) {
    _$polylineAtom.reportWrite(value, super.polyline, () {
      super.polyline = value;
    });
  }

  final _$polygonAtom = Atom(name: 'MobxPointBase.polygon');

  @override
  ObservableList<Polygon> get polygon {
    _$polygonAtom.reportRead();
    return super.polygon;
  }

  @override
  set polygon(ObservableList<Polygon> value) {
    _$polygonAtom.reportWrite(value, super.polygon, () {
      super.polygon = value;
    });
  }

  final _$refreshAtom = Atom(name: 'MobxPointBase.refresh');

  @override
  bool get refresh {
    _$refreshAtom.reportRead();
    return super.refresh;
  }

  @override
  set refresh(bool value) {
    _$refreshAtom.reportWrite(value, super.refresh, () {
      super.refresh = value;
    });
  }

  final _$isSelectedAtom = Atom(name: 'MobxPointBase.isSelected');

  @override
  bool get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(bool value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  final _$isConnectedAtom = Atom(name: 'MobxPointBase.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$latitudeAtom = Atom(name: 'MobxPointBase.latitude');

  @override
  double get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  final _$longitudeAtom = Atom(name: 'MobxPointBase.longitude');

  @override
  double get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  final _$id_secteurAtom = Atom(name: 'MobxPointBase.id_secteur');

  @override
  String get id_secteur {
    _$id_secteurAtom.reportRead();
    return super.id_secteur;
  }

  @override
  set id_secteur(String value) {
    _$id_secteurAtom.reportWrite(value, super.id_secteur, () {
      super.id_secteur = value;
    });
  }

  final _$configPolylineAtom = Atom(name: 'MobxPointBase.configPolyline');

  @override
  bool get configPolyline {
    _$configPolylineAtom.reportRead();
    return super.configPolyline;
  }

  @override
  set configPolyline(bool value) {
    _$configPolylineAtom.reportWrite(value, super.configPolyline, () {
      super.configPolyline = value;
    });
  }

  final _$configPolygonAtom = Atom(name: 'MobxPointBase.configPolygon');

  @override
  bool get configPolygon {
    _$configPolygonAtom.reportRead();
    return super.configPolygon;
  }

  @override
  set configPolygon(bool value) {
    _$configPolygonAtom.reportWrite(value, super.configPolygon, () {
      super.configPolygon = value;
    });
  }

  final _$configMarkersAtom = Atom(name: 'MobxPointBase.configMarkers');

  @override
  bool get configMarkers {
    _$configMarkersAtom.reportRead();
    return super.configMarkers;
  }

  @override
  set configMarkers(bool value) {
    _$configMarkersAtom.reportWrite(value, super.configMarkers, () {
      super.configMarkers = value;
    });
  }

  final _$configZoomAtom = Atom(name: 'MobxPointBase.configZoom');

  @override
  double get configZoom {
    _$configZoomAtom.reportRead();
    return super.configZoom;
  }

  @override
  set configZoom(double value) {
    _$configZoomAtom.reportWrite(value, super.configZoom, () {
      super.configZoom = value;
    });
  }

  final _$MobxPointBaseActionController =
      ActionController(name: 'MobxPointBase');

  @override
  void setPosition(LatLng position) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.setPosition');
    try {
      return super.setPosition(position);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPoint(dynamic location, String id, dynamic icon, int index) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.addPoint');
    try {
      return super.addPoint(location, id, icon, index);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelect(bool selected) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.onSelect');
    try {
      return super.onSelect(selected);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectPolyline(bool selected) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.onSelectPolyline');
    try {
      return super.onSelectPolyline(selected);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectRefresh(bool selected) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.onSelectRefresh');
    try {
      return super.onSelectRefresh(selected);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectPolygon(bool selected) {
    final _$actionInfo = _$MobxPointBaseActionController.startAction(
        name: 'MobxPointBase.onSelectPolygon');
    try {
      return super.onSelectPolygon(selected);
    } finally {
      _$MobxPointBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pointModel: ${pointModel},
markers: ${markers},
latLngs: ${latLngs},
polyline: ${polyline},
polygon: ${polygon},
refresh: ${refresh},
isSelected: ${isSelected},
isConnected: ${isConnected},
latitude: ${latitude},
longitude: ${longitude},
id_secteur: ${id_secteur},
configPolyline: ${configPolyline},
configPolygon: ${configPolygon},
configMarkers: ${configMarkers},
configZoom: ${configZoom}
    ''';
  }
}
