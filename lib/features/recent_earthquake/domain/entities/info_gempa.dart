import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'gempa.dart';

class Infogempa extends Equatable {
  final Gempa gempa;

  Infogempa({@required this.gempa});

  Infogempa copyWith({
    Gempa gempa,
  }) =>
      Infogempa(gempa: gempa ?? this.gempa);

  @override
  List<Object> get props => [gempa];
}
