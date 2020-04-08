import 'package:equatable/equatable.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/gempa.dart';
import 'package:meta/meta.dart';

class Infogempa extends Equatable {
  final List<Gempa> gempa;

  Infogempa({@required this.gempa});

  Infogempa copyWith({
    List<Gempa> gempa,
  }) =>
      Infogempa(gempa: gempa ?? this.gempa);

  @override
  List<Object> get props => [gempa];
}
