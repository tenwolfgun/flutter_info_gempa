import 'package:meta/meta.dart';

import '../../domain/entities/gempa.dart';
import '../../domain/entities/info_gempa.dart';
import 'gempa_model.dart';

class InfoGempaModel extends Infogempa {
  InfoGempaModel({
    @required Gempa gempa,
  }) : super(gempa: gempa);

  factory InfoGempaModel.fromJson(Map<String, dynamic> json) => InfoGempaModel(
        gempa:
            json["gempa"] == null ? null : GempaModel.fromJson(json["gempa"]),
      );

  Map<String, dynamic> toJson() => {
        "gempa": gempa ?? null,
      };
}
