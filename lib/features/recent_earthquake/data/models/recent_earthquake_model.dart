import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/info_gempa.dart';
import '../../domain/entities/recent_earthquake.dart';
import 'info_gempa_model.dart';

RecentEarthquake recentEarthquakeFromJson(String str) =>
    RecentEarthquakeModel.fromJson(json.decode(str));

String recentEarthquakeToJson(RecentEarthquakeModel data) =>
    json.encode(data.toJson());

class RecentEarthquakeModel extends RecentEarthquake {
  RecentEarthquakeModel({@required Infogempa infogempa})
      : super(infogempa: infogempa);

  factory RecentEarthquakeModel.fromJson(Map<String, dynamic> json) =>
      RecentEarthquakeModel(
        infogempa: json["Infogempa"] == null
            ? null
            : InfoGempaModel.fromJson(json["Infogempa"]),
      );

  Map<String, dynamic> toJson() => {
        "Infogempa": infogempa ?? null,
      };
}
