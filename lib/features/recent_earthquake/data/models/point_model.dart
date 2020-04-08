import '../../domain/entities/point.dart';
import 'package:meta/meta.dart';

class PointModel extends Point {
  PointModel({
    @required String coordinates,
  }) : super(coordinates: coordinates);

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        coordinates: json["coordinates"] == null ? null : json["coordinates"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates ?? null,
      };
}
