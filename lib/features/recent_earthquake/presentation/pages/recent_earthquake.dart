import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/recent_earthquake_state.dart';

class RecentEarthquake extends StatelessWidget {
  final LoadedState state;

  const RecentEarthquake({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: 8.w,
        left: 8.w,
        right: 8.w,
        bottom: 16.w,
      ),
      shrinkWrap: true,
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "Potensi",
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                state.recentEarthquake.infogempa.gempa.potensi,
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Waktu dan Tanggal",
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '${state.recentEarthquake.infogempa.gempa.jam}, ${state.recentEarthquake.infogempa.gempa.tanggal}',
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Lintang",
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black.withOpacity(0.7),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.recentEarthquake.infogempa.gempa.lintang,
                      style: TextStyle(
                        fontSize: 40.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Bujur",
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black.withOpacity(0.7),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.recentEarthquake.infogempa.gempa.bujur,
                      style: TextStyle(
                        fontSize: 40.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Magnitude",
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black.withOpacity(0.7),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.recentEarthquake.infogempa.gempa.magnitude,
                      style: TextStyle(
                        fontSize: 40.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Kedalaman",
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black.withOpacity(0.7),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.recentEarthquake.infogempa.gempa.kedalaman,
                      style: TextStyle(
                        fontSize: 40.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              isThreeLine: true,
              title: Text(
                "Lokasi gempa",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black.withOpacity(0.7),
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '''${state.recentEarthquake.infogempa.gempa.wilayah1}
${state.recentEarthquake.infogempa.gempa.wilayah2}
${state.recentEarthquake.infogempa.gempa.wilayah3}
${state.recentEarthquake.infogempa.gempa.wilayah4}
${state.recentEarthquake.infogempa.gempa.wilayah5}''',
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                ),
                softWrap: true,
              ),
            ),
            ListTile(
              title: Text(
                "Sumber",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black.withOpacity(0.7),
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "Badan Meteorologi, Klimatologi, dan Geofisika",
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
