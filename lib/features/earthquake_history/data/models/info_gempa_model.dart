import 'package:meta/meta.dart';

import '../../domain/entities/gempa.dart';
import '../../domain/entities/info_gempa.dart';
import 'gempa_model.dart';

class InfoGempaModel extends Infogempa {
  InfoGempaModel({
    @required List<Gempa> gempa,
  }) : super(gempa: gempa);

  factory InfoGempaModel.fromJson(Map<String, dynamic> json) => InfoGempaModel(
        gempa: json["gempa"] == null
            ? null
            : List<Gempa>.from(
                json["gempa"].map((x) => GempaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gempa": gempa ?? null,
      };
}
