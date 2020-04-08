import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/gempa.dart';
import '../bloc/earthquake_history_state.dart';

class EarthquakeHistory extends StatelessWidget {
  final LoadedState state;
  final ItemScrollController scrollController;
  final Completer<GoogleMapController> mapController;

  const EarthquakeHistory({
    Key key,
    this.state,
    this.scrollController,
    this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(8),
        left: ScreenUtil().setWidth(8),
        right: ScreenUtil().setWidth(8),
      ),
      itemCount: state.earthquakeHistory.infogempa.gempa.length,
      itemScrollController: scrollController,
      itemBuilder: (context, i) {
        return _buildExpandedTile(
            state.earthquakeHistory.infogempa.gempa[i], i);
      },
    );
  }

  Widget _buildExpandedTile(Gempa gempa, int i) {
    return ExpansionTile(
      leading: i == 0
          ? Icon(
              Icons.fiber_new,
            )
          : Text(""),
      onExpansionChanged: ((t) {
        if (t) {
          Utils().goToMapMarkerAndClearList(
            id: gempa.jam,
            mapController: mapController,
            coordinate: gempa.point.coordinates,
          );
        } else {
          Utils().hideMapMarker(mapController: mapController, id: gempa.jam);
        }
      }),
      title: Text(
        '${gempa.jam}, ${gempa.tanggal}',
        style: TextStyle(
          fontSize: 40.sp,
        ),
      ),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "Lintang",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
                subtitle: Text(
                  gempa.lintang,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  "Bujur",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
                subtitle: Text(
                  gempa.bujur,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "Magnitude",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
                subtitle: Text(
                  gempa.magnitude,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  "Kedalaman",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
                subtitle: Text(
                  gempa.kedalaman,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        ListTile(
          title: Text(
            "Wilayah",
            style: TextStyle(
              height: 1.5,
              fontSize: 40.sp,
            ),
          ),
          subtitle: Text(
            gempa.wilayah,
            style: TextStyle(
              height: 1.5,
              fontSize: 40.sp,
            ),
          ),
        ),
      ],
    );
  }
}
