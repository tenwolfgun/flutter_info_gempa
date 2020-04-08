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
    @required String wilayah,
  }) : super(
          tanggal: tanggal,
          jam: jam,
          point: point,
          lintang: lintang,
          bujur: bujur,
          magnitude: magnitude,
          kedalaman: kedalaman,
          symbol: symbol,
          wilayah: wilayah,
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
        wilayah: json["Wilayah"] == null ? null : json["Wilayah"],
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
        "Wilayah": wilayah ?? null,
      };
}
