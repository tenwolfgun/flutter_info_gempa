import 'package:meta/meta.dart';

import '../../domain/entities/gempa.dart';
import '../../domain/entities/point.dart';
import 'point_model.dart';

class GempaModel extends Gempa {
  GempaModel({
    @required String tanggal,
    @required String jam,
    @required Point point,
    @required String lintang,
    @required String bujur,
    @required String magnitude,
    @required String kedalaman,
    @required String symbol,
    @required String wilayah1,
    @required String wilayah2,
    @required String wilayah3,
    @required String wilayah4,
    @required String wilayah5,
    @required String potensi,
  }) : super(
          tanggal: tanggal,
          jam: jam,
          point: point,
          lintang: lintang,
          bujur: bujur,
          magnitude: magnitude,
          kedalaman: kedalaman,
          symbol: symbol,
          wilayah1: wilayah1,
          wilayah2: wilayah2,
          wilayah3: wilayah3,
          wilayah4: wilayah4,
          wilayah5: wilayah5,
          potensi: potensi,
        );

  factory GempaModel.fromJson(Map<String, dynamic> json) => GempaModel(
        tanggal: json["Tanggal"] == null ? null : json["Tanggal"],
        jam: json["Jam"] == null ? null : json["Jam"],
        point:
            json["point"] == null ? null : PointModel.fromJson(json["point"]),
        lintang: json["Lintang"] == null ? null : json["Lintang"],
        bujur: json["Bujur"] == null ? null : json["Bujur"],
        magnitude: json["Magnitude"] == null ? null : json["Magnitude"],
        kedalaman: json["Kedalaman"] == null ? null : json["Kedalaman"],
        symbol: json["_symbol"] == null ? null : json["_symbol"],
        wilayah1: json["Wilayah1"] == null ? null : json["Wilayah1"],
        wilayah2: json["Wilayah2"] == null ? null : json["Wilayah2"],
        wilayah3: json["Wilayah3"] == null ? null : json["Wilayah3"],
        wilayah4: json["Wilayah4"] == null ? null : json["Wilayah4"],
        wilayah5: json["Wilayah5"] == null ? null : json["Wilayah5"],
        potensi: json["Potensi"] == null ? null : json["Potensi"],
      );

  Map<String, dynamic> toJson() => {
        "Tanggal": tanggal ?? null,
        "Jam": jam ?? null,
        "point": point ?? null,
        "Lintang": lintang ?? null,
        "Bujur": bujur ?? null,
        "Magnitude": magnitude ?? null,
        "Kedalaman": kedalaman ?? null,
        "_symbol": symbol ?? null,
        "Wilayah1": wilayah1 ?? null,
        "Wilayah2": wilayah2 ?? null,
        "Wilayah3": wilayah3 ?? null,
        "Wilayah4": wilayah4 ?? null,
        "Wilayah5": wilayah5 ?? null,
        "Potensi": potensi ?? null,
      };
}
