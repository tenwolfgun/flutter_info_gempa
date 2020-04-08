import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'info_gempa.dart';

class RecentEarthquake extends Equatable {
  final Infogempa infogempa;

  RecentEarthquake({@required this.infogempa});

  RecentEarthquake copyWith({
    Infogempa infogempa,
  }) =>
      RecentEarthquake(infogempa: infogempa ?? this.infogempa);

  @override
  List<Object> get props => [infogempa];
}
