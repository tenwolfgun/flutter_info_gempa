import 'dart:convert';

import 'package:info_gempa/features/earthquake_history/data/models/info_gempa_model.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/earthquake_history.dart';
import '../../domain/entities/info_gempa.dart';

EarthquakeHistoryModel earthquakeHistoryFromJson(String str) =>
    EarthquakeHistoryModel.fromJson(json.decode(str));

String earthquakeHistoryToJson(EarthquakeHistoryModel data) =>
    json.encode(data.toJson());

class EarthquakeHistoryModel extends EarthquakeHistory {
  EarthquakeHistoryModel({@required Infogempa infogempa})
      : super(infogempa: infogempa);

  factory EarthquakeHistoryModel.fromJson(Map<String, dynamic> json) =>
      EarthquakeHistoryModel(
        infogempa: json["Infogempa"] == null
            ? null
            : InfoGempaModel.fromJson(json["Infogempa"]),
      );

  Map<String, dynamic> toJson() => {
        "Infogempa": infogempa ?? null,
      };
}
