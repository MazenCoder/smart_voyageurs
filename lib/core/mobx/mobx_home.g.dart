// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_home.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxHome on MobxHomeBase, Store {
  final _$isSelectedAtom = Atom(name: 'MobxHomeBase.isSelected');

  @override
  ObservableList<bool> get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(ObservableList<bool> value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  final _$markersAtom = Atom(name: 'MobxHomeBase.markers');

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

  final _$latlngsAtom = Atom(name: 'MobxHomeBase.latlngs');

  @override
  ObservableList<LatLng> get latlngs {
    _$latlngsAtom.reportRead();
    return super.latlngs;
  }

  @override
  set latlngs(ObservableList<LatLng> value) {
    _$latlngsAtom.reportWrite(value, super.latlngs, () {
      super.latlngs = value;
    });
  }

  final _$polylinesAtom = Atom(name: 'MobxHomeBase.polylines');

  @override
  ObservableList<Polyline> get polylines {
    _$polylinesAtom.reportRead();
    return super.polylines;
  }

  @override
  set polylines(ObservableList<Polyline> value) {
    _$polylinesAtom.reportWrite(value, super.polylines, () {
      super.polylines = value;
    });
  }

  final _$latitudeAtom = Atom(name: 'MobxHomeBase.latitude');

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

  final _$longitudeAtom = Atom(name: 'MobxHomeBase.longitude');

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

  final _$alertAtom = Atom(name: 'MobxHomeBase.alert');

  @override
  bool get alert {
    _$alertAtom.reportRead();
    return super.alert;
  }

  @override
  set alert(bool value) {
    _$alertAtom.reportWrite(value, super.alert, () {
      super.alert = value;
    });
  }

  final _$isSearchAtom = Atom(name: 'MobxHomeBase.isSearch');

  @override
  bool get isSearch {
    _$isSearchAtom.reportRead();
    return super.isSearch;
  }

  @override
  set isSearch(bool value) {
    _$isSearchAtom.reportWrite(value, super.isSearch, () {
      super.isSearch = value;
    });
  }

  final _$isPolyLineAtom = Atom(name: 'MobxHomeBase.isPolyLine');

  @override
  bool get isPolyLine {
    _$isPolyLineAtom.reportRead();
    return super.isPolyLine;
  }

  @override
  set isPolyLine(bool value) {
    _$isPolyLineAtom.reportWrite(value, super.isPolyLine, () {
      super.isPolyLine = value;
    });
  }

  final _$currentIndexAtom = Atom(name: 'MobxHomeBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$queryAtom = Atom(name: 'MobxHomeBase.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$typeAtom = Atom(name: 'MobxHomeBase.type');

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$modeAtom = Atom(name: 'MobxHomeBase.mode');

  @override
  String get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(String value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  final _$cutPolygonAtom = Atom(name: 'MobxHomeBase.cutPolygon');

  @override
  bool get cutPolygon {
    _$cutPolygonAtom.reportRead();
    return super.cutPolygon;
  }

  @override
  set cutPolygon(bool value) {
    _$cutPolygonAtom.reportWrite(value, super.cutPolygon, () {
      super.cutPolygon = value;
    });
  }

  final _$MobxHomeBaseActionController = ActionController(name: 'MobxHomeBase');

  @override
  void setSearch(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setSearch');
    try {
      return super.setSearch(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPolyLine(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setPolyLine');
    try {
      return super.setPolyLine(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocation(Position val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setLocation');
    try {
      return super.setLocation(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLatLng(LatLng val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.addLatLng');
    try {
      return super.addLatLng(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPolyline(Polyline val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.addPolyline');
    try {
      return super.addPolyline(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMarker(LatLng val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.addMarker');
    try {
      return super.addMarker(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlert(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setAlert');
    try {
      return super.setAlert(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex(int val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setIndex');
    try {
      return super.setIndex(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuery(String search) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setQuery');
    try {
      return super.setQuery(search);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setType(String val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setType');
    try {
      return super.setType(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMode(String val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setMode');
    try {
      return super.setMode(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCutPolygon(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setCutPolygon');
    try {
      return super.setCutPolygon(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSelected: ${isSelected},
markers: ${markers},
latlngs: ${latlngs},
polylines: ${polylines},
latitude: ${latitude},
longitude: ${longitude},
alert: ${alert},
isSearch: ${isSearch},
isPolyLine: ${isPolyLine},
currentIndex: ${currentIndex},
query: ${query},
type: ${type},
mode: ${mode},
cutPolygon: ${cutPolygon}
    ''';
  }
}
