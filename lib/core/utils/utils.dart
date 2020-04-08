import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  void goToMapMarker({
    @required double lat,
    @required double lng,
    @required Completer<GoogleMapController> mapController,
  }) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 5,
        ),
      ),
    );
  }

  void goToMapMarkerAndClearList({
    @required String id,
    @required Completer<GoogleMapController> mapController,
    @required String coordinate,
  }) async {
    final GoogleMapController controller = await mapController.future;
    List<String> _splitCoordinate = coordinate.split(',');
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _splitCoordinate[1] == null
                ? -6.200000
                : double.tryParse(_splitCoordinate[1]),
            _splitCoordinate[0] == null
                ? 106.816666
                : double.tryParse(_splitCoordinate[0]),
          ),
          zoom: 5,
        ),
      ),
    );
    controller.showMarkerInfoWindow(MarkerId(id));
    _splitCoordinate.clear();
  }

  void hideMapMarker({
    @required Completer<GoogleMapController> mapController,
    @required String id,
  }) async {
    final GoogleMapController controller = await mapController.future;
    controller.hideMarkerInfoWindow(MarkerId(id));
  }

  void showSnackBar({
    GlobalKey<ScaffoldState> scaffoldKey,
    String message,
    Color color,
    Widget child,
  }) {
    scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 40.sp),
                ),
              ),
              child,
            ],
          ),
          backgroundColor: color,
        ),
      );
  }
}
