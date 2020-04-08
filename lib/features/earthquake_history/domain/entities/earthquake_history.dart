import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'info_gempa.dart';

class EarthquakeHistory extends Equatable {
  final Infogempa infogempa;

  EarthquakeHistory({@required this.infogempa});

  EarthquakeHistory copyWith({
    Infogempa infogempa,
  }) =>
      EarthquakeHistory(infogempa: infogempa ?? this.infogempa);

  @override
  List<Object> get props => [infogempa];
}
